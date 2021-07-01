//
//  DetailEpisodeViewController.swift
//  Final Space Wiki
//
//  Created by Robert Taylor on 23/06/2021.
//

import Foundation
import UIKit
import SDWebImage

class EpisodeCollectionCell: CollectionViewCell {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
}


class DetailEpisodeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, EpisodeCharactersManagerDelegate {
    
    
    
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var airDate: UILabel!
    @IBOutlet weak var writer: UILabel!
    @IBOutlet weak var Director: UILabel!
    @IBOutlet weak var episodeCollectionView: UICollectionView!
    
    var imageUrl: String = ""
    var airDateText: String = ""
    var writerText: String = ""
    var directorText: String = ""
    var characters: [String] = []
    var episodeName: String = ""
    var characterManager = EpisodeCharactersManager()
    var characterCount: Int = 0
    var finalChar: [EpisodeCharacter] = []
    var charImg: [String] = []
    var charName: [String] = []
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeImage.sd_setImage(with: URL(string: imageUrl))
        airDate.text = airDateText
        writer.text = writerText
        Director.text = directorText
        self.navigationItem.title = episodeName
        episodeCollectionView.delegate = self
        episodeCollectionView.dataSource = self
        self.getCharacters()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = episodeCollectionView.dequeueReusableCell(withReuseIdentifier: "episodeCollectionCell", for: indexPath) as! EpisodeCollectionCell
        self.dispatchGroup.notify(queue: .main) {
            cell.characterName.text = self.finalChar[indexPath.row].name
            cell.characterImage.sd_setImage(with: URL(string: self.finalChar[indexPath.row].img_url))
        }
        return cell
    }
    
        func getCharacters() {
            let dispatchGroup = DispatchGroup()
                dispatchGroup.enter()
                let urlArray = characters.compactMap { URL(string:$0)}
                characterManager.loadCharacterData(urls: urlArray)
                dispatchGroup.leave()

            dispatchGroup.notify(queue: .main) {
                self.finalChar = self.characterManager.characters
                self.episodeCollectionView.reloadData()
            }
            
        }
    
    
    
    func didRecieveDataUpdate(data: EpisodeCharacter) {
        self.episodeCollectionView.reloadData()
    }
    
    
}
