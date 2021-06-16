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
   
    
    


}
