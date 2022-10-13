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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let view = AirportsViewController.instantiate()
        self.navigationController.pushViewController(view, animated: true)
        
    }
    
    
}
