//
//  AirportsCoordinator.swift
//  Airports
//
//  Created by Maksim  on 13.10.2022.
//

import Foundation
import UIKit

class AirportsCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController
    private let models: Set<AirportModel>
    
    init(navigationController: UINavigationController, models: Set<AirportModel>) {
        self.models = models
        self.navigationController = navigationController
    }
    
    override func start() {
        let view = AirportsViewController.instantiate()
        let locationService = LocationService.shared
        
        view.viewModelBuilder = { [models, locationService] in
            let title = models.first?.city ?? ""
            return AirportsViewModel(input: $0,
                                     dependencies: (
                                        title: title,
                                        models: models,
                                        currentLocation: locationService.currentLocation)
            )
            
        }

        self.navigationController.pushViewController(view, animated: true)
        
    }
    
    
}
