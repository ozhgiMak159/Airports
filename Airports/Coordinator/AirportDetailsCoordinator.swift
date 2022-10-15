//
//  AirportDetailsCoordinator.swift
//  Airports
//
//  Created by Maksim  on 15.10.2022.
//

import Foundation

class AirportDetailsCoordinator: BaseCoordinator {
    
    private let router: Routing
    
     init(router: Routing) {
         self.router = router
    }
    
    override func start() {
        let view = AirportDetailViewController.instantiate()
        router.present(view, isAnimated: true, onDismiss: isCompleted)
    }
    
}
