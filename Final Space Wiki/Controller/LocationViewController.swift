//
//  LocationViewController.swift
//  Final Space Wiki
//
//  Created by Robert Taylor on 15/06/2021.
//

import UIKit

class LocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LocationManagerDelegate {
    
    var locationManager = LocationManager()
    var locations = [Location]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.loadLocationData()
        tableView.delegate = self
        tableView.dataSource = self
        locations = locationManager.locations
        tableView.backgroundColor = UIColor(named: "locationGreen")
        self.view.backgroundColor = UIColor(named: "locationGreen")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! LocationViewCell
        
        cell.locationNameLbl.text = locations[indexPath.row].name
        cell.locationTypeLbl.text = locations[indexPath.row].type
        let inhabString = locations[indexPath.row].inhabitants.joined(separator: ", ")
        if locations[indexPath.row].inhabitants != [] {
            cell.locationInhabitantsLbl.text = inhabString
        } else {
            cell.locationInhabitantsLbl.text = "Unknown"
        }
        cell.locationImg.sd_setImage(with: URL(string: locations[indexPath.row].img_url))
        return cell
    }
    
    func didRecieveDataUpdate(data: [Location]) {
        self.locations = data
        self.tableView.reloadData()
    }

}
