//
//  EpisodeViewController.swift
//  Final Space Wiki
//
//  Created by Robert Taylor on 15/06/2021.
//

import UIKit
import SDWebImage

class EpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EpisodeManagerDelegate {
    
    var episodeManager = EpisodeManager()
    var episodes = [Episode]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeManager.delegate = self
        episodeManager.loadEpisodeData()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = "Episodes"
        tableView.backgroundColor = UIColor(named: "episodeOrange")
        self.view.backgroundColor = UIColor(named: "episodeOrange")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as! EpisodeCellView
        
        cell.episodeTitle.text = episodes[indexPath.row].name
        cell.episodeAirDate.text = episodes[indexPath.row].air_date
        let imageUrl = episodes[indexPath.row].img_url
        cell.episodeImage.sd_setImage(with: URL(string: imageUrl))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailEpisodeView") as? DetailEpisodeViewController
        vc?.airDateText = episodes[indexPath.row].air_date
        vc?.directorText = episodes[indexPath.row].director
        vc?.imageUrl = episodes[indexPath.row].img_url
        vc?.writerText = episodes[indexPath.row].writer
        vc?.episodeName = episodes[indexPath.row].name
        vc?.characterCount = episodes[indexPath.row].characters.count
        vc?.charArray = episodes[indexPath.row].characters
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func didRecieveDataUpdate(data: [Episode]) {
        self.episodes = data
        self.tableView.reloadData()
    }

}
