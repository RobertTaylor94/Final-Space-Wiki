//
//  EpisodeCharactersManager.swift
//  Final Space Wiki
//
//  Created by Robert Taylor on 23/06/2021.
//

import Foundation

protocol EpisodeCharactersManagerDelegate {
    func didRecieveDataUpdate(data: EpisodeCharacter)
}

class EpisodeCharactersManager {
    
    var delegate: EpisodeCharactersManagerDelegate?
    var characters: [EpisodeCharacter] = []
    
    func loadCharacterData(urls: [URL]) {
        
        
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "com.urlDownloader.urlqueue")
        
        urls.forEach { (url) in
            dispatchGroup.enter()
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    dispatchQueue.async {
                        dispatchGroup.leave()
                    }
                    return
                }
                if let safeData = data {
                    if let characters = self.parseJson(safeData) {
                        dispatchQueue.async {
                            self.delegate?.didRecieveDataUpdate(data: characters)
                            self.characters.append(characters)
                        }
                    }
                }
            }
            task.resume()
            
//            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
//                guard let data = data,
//                      let subject = try? self.parseJson(data)
//                else {
//                    print(error!)
//                    dispatchQueue.async {
//                        dispatchGroup.leave()
//                    }
//                    return
//                }
//
//                dispatchQueue.async {
//                    self.characters.append(subject)
//                    dispatchGroup.leave()
//                }
//
//
//            })
//
//        }
//
//        dispatchGroup.notify(queue: DispatchQueue.global()) {
//
//        }
        
        
//        if let url = URL(string: url) {
//            let session = URLSession(configuration: .default)
//
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//                if let safeData = data {
//                    if let characters = self.parseJson(safeData) {
//                        DispatchQueue.main.async {
//                            self.delegate?.didRecieveDataUpdate(data: characters)
//                            self.characters = characters
//                            print(self.characters?.name)
//                        }
//                    }
//                }
//            }
//            task.resume()
//        }
        
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
