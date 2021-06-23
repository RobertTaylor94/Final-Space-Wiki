//
//  EpisodeManager.swift
//  Final Space Wiki
//
//  Created by Robert Taylor on 23/06/2021.
//

import Foundation

protocol EpisodeManagerDelegate {
    func didRecieveDataUpdate(data: [Episode])
}


class EpisodeManager {
    
    var delegate: EpisodeManagerDelegate?
    var episodes: [Episode] = []
    
    func loadEpisodeData() {
        if let url = URL(string: "https://finalspaceapi.com/api/v0/episode/") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let episodes = self.parseJson(safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.didRecieveDataUpdate(data: episodes)
                            self.episodes = episodes
                        }
                        return
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJson(_ episodeData: Data) -> [Episode]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Episode].self, from: episodeData)
            let episodes: [Episode] = decodedData
            return episodes
        } catch {
            print(error)
            return nil
        }
    }
    
    
    
}
