//
//  EpisodeCharactersManager.swift
//  Final Space Wiki
//
//  Created by Robert Taylor on 23/06/2021.
//

import Foundation

protocol EpisodeCharactersManagerDelegate {
    func didRecieveDataUpdate(date: EpisodeCharacter)
}

class EpisodeCharactersManager {
    
    var delegate: EpisodeCharactersManagerDelegate?
    var characters: EpisodeCharacter?
    
    func loadCharacterData(url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let characters = self.parseJson(safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.didRecieveDataUpdate(date: characters)
                            self.characters = characters
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ charData: Data) -> EpisodeCharacter? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(EpisodeCharacter.self, from: charData)
            let characters: EpisodeCharacter = decodedData
            return characters
        } catch {
            print(error)
            return nil
        }
    }
}
