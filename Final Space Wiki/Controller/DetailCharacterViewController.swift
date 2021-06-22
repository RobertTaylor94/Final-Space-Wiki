//
//  DetailCharacterView.swift
//  Final Space Wiki
//
//  Created by Robert Taylor on 22/06/2021.
//

import Foundation
import UIKit
import SDWebImage

class DetailCharacterViewController: UIViewController {
    
    @IBOutlet weak var charImage: UIImageView!
    @IBOutlet weak var charStatus: UILabel!
    @IBOutlet weak var charSpecies: UILabel!
    @IBOutlet weak var charGender: UILabel!
    @IBOutlet weak var charAlias: UILabel!
    @IBOutlet weak var charOrigin: UILabel!
    @IBOutlet weak var charAbilities: UILabel!
    
    var imageUrl: String = ""
    var charName: String = ""
    var status: String = ""
    var species: String = ""
    var gender: String = ""
    var aliasString: String = ""
    var origin: String = ""
    var abilitiesString: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charImage.sd_setImage(with: URL(string: imageUrl))
        charStatus.text = status
        charSpecies.text = species
        charGender.text = gender
        charAlias.text = aliasString
        charOrigin.text = origin
        charAbilities.text = abilitiesString
        self.navigationItem.title = charName
        self.view.backgroundColor = UIColor(hue: 356, saturation: 100, brightness: 20, alpha: 1)
    }
    
}
