//
//  AirportTableViewCell.swift
//  Airports
//
//  Created by Maksim  on 13.10.2022.
//

import UIKit

class AirportTableViewCell: UITableViewCell {

    @IBOutlet weak var airportNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configure(model: AirportViewPresentable) {
        airportNameLabel.text = model.name
        distanceLabel.text = model.formattedDistance
        countryLabel.text =  model.address + ","
        lengthLabel.text = model.runwayLength
        self.selectionStyle = .none
    }
    
}
