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
    var characters: [EpisodeCharacter] = []
    var episodeName: String = ""
    var characterManager = EpisodeCharactersManager()
    var characterCount: Int = 0
    var charArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeImage.sd_setImage(with: URL(string: imageUrl))
        airDate.text = airDateText
        writer.text = writerText
        Director.text = directorText
        self.navigationItem.title = episodeName
        episodeCollectionView.delegate = self
        episodeCollectionView.dataSource = self
//        self.getCharacters()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = episodeCollectionView.dequeueReusableCell(withReuseIdentifier: "episodeCollectionCell", for: indexPath) as! EpisodeCollectionCell
//        cell.characterName = characters[indexPath.row]
//        cell.characterImage.sd_setImage(with: URL(string: characters[indexPath.row].imgUrl))
        return cell
    }
    
//    func getCharacters() {
//        for i in 0 ... characterCount {
//            characterManager.loadCharacterData(url: charArray[i])
//            self.characters.append(characterManager.characters)
//        }
//    }
    
    func didRecieveDataUpdate(date: EpisodeCharacter) {
        self.episodeCollectionView.reloadData()
    }
    
    
}
