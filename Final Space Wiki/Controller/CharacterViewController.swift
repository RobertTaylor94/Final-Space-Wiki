//
//  CharacterViewController.swift
//  Final Space Wiki
//
//  Created by Robert Taylor on 15/06/2021.
//

import UIKit
import SDWebImage

class CharacterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CharacterManagerDelegate {

    @IBOutlet weak var charCollectionView: UICollectionView!
    
    
    
    let characterManager = CharacterManager()
    var items = [character]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterManager.delegate = self
        charCollectionView.dataSource = self
        charCollectionView.delegate = self
        characterManager.loadCharacterData()
        items = characterManager.characters
        self.view.backgroundColor = UIColor.black
    }
    
    func didRecieveDataUpdate(data: [character]) {
        self.items = data
        self.charCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.items.count)
        return self.items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CollectionViewCell
        
        cell.charName.text = items[indexPath.row].name
        cell.charImage.sd_setImage(with: URL(string: items[indexPath.row].img_url))
        cell.charImage.clipsToBounds = true
        cell.charImage.layer.cornerRadius = 50
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailCharacterViewController") as? DetailCharacterViewController
        vc?.charName = items[indexPath.row].name
        vc?.imageUrl = items[indexPath.row].img_url
        vc?.status = items[indexPath.row].status
        vc?.species = items[indexPath.row].species ?? ""
        vc?.gender = items[indexPath.row].gender
        let aliasString = items[indexPath.row].alias.joined(separator: ", ")
        vc?.aliasString = aliasString
        vc?.origin = items[indexPath.row].origin
        let abilitiesString = items[indexPath.row].abilities?.joined(separator: ", ")
        vc?.abilitiesString = abilitiesString ?? ""
        self.navigationController?.pushViewController(vc!, animated: true)
    }
   
    
    


}
