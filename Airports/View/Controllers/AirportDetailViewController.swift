//
//  AirportDetailViewController.swift
//  Airports
//
//  Created by Maksim  on 15.10.2022.
//

import UIKit
import MapKit

class AirportDetailViewController: UIViewController, Storyboardable {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var airportName: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var runwayLength: UILabel!
    
    var viewModelBuilder: AirportDetailsViewPresentable.ViewModelBuilder!
    private var viewModel: AirportDetailsViewPresentable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = viewModelBuilder(())
    }
    

 

}
