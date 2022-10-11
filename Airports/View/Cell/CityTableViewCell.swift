//
//  CityTableViewCell.swift
//  Airports
//
//  Created by Maksim  on 11.10.2022.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    func configure(viewModel: CityViewPresentable)  {
        self.cityLabel.text = viewModel.city
        self.locationLabel.text = viewModel.location
        
    }
    
    
}
