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
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(viewModel: CityViewPresentable)  {
       
        self.cityLabel.text = viewModel.city
        self.locationLabel.text = viewModel.location
        
    }
    
    
}
