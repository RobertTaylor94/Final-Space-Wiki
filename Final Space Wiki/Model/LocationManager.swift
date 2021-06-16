//
//  LocationManager.swift
//  Final Space Wiki
//
//  Created by Robert Taylor on 16/06/2021.
//

import Foundation

protocol LocationManagerDelegate {
    func didRecieveDataUpdate(data: [Location])
}

class LocationManager {
    
    var delegate: LocationManagerDelegate?
    var locations: [Location] = []
    
    func loadLocationData() {
          if let url = URL(string: "https://finalspaceapi.com/api/v0/location/") {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let locations = self.parseJson(safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.didRecieveDataUpdate(data: locations)
                            self.locations = locations
                        }
                        return
                    }
                }
            }
            task.resume()
        }
        
                
                
    }

    func parseJson(_ locationData: Data) -> [Location]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Location].self, from: locationData)
            let locations: [Location] = decodedData
            return locations
        } catch {
            print(error)
            return nil
        }
   
    }

}

