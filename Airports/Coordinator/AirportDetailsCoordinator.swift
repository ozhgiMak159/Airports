//
//  AirportDetailsCoordinator.swift
//  Airports
//
//  Created by Maksim  on 15.10.2022.
//

import Foundation

class AirportDetailsCoordinator: BaseCoordinator {
    
    private let router: Routing
    private let model: AirportModel
    
    init(model: AirportModel, router: Routing) {
        self.model = model
        self.router = router
    }
    
    override func start() {
        let view = AirportDetailViewController.instantiate()
        let locationService = LocationService.shared
        
        view.viewModelBuilder = { [model, locationService] in
            AirportDetailsViewModel(
                input: $0,
                dependencies: (model: model, currentLocation: locationService.currentLocation ))
        }
        
        
        router.present(view, isAnimated: true, onDismiss: isCompleted)
    }
    
}
