//
//  NetworkManager.swift
//  Final Space Wiki
//
//  Created by Robert Taylor on 15/06/2021.
//

import Foundation


protocol CharacterManagerDelegate {
    func didRecieveDataUpdate(data: [character])
}

class CharacterManager {
    
    var delegate: CharacterManagerDelegate?
    var characters: [character] = []
    
    func loadCharacterData() {
          if let url = URL(string: "https://finalspaceapi.com/api/v0/character/") {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let characters = self.parseJson(safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.didRecieveDataUpdate(data: characters)
                            self.characters = characters
                        }
                        return
                    }
                }
            }
            task.resume()
        }
        
                
                
    }

    func parseJson(_ charData: Data) -> [character]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([character].self, from: charData)
            let characters: [character] = decodedData
            return characters
        } catch {
            print(error)
            return nil
        }
   
    }

}

