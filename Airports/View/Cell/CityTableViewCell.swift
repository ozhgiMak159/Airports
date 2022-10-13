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
        cityLabel.text = viewModel.city
        locationLabel.text = viewModel.location
        self.selectionStyle = .none

    }
    
    
}
