//
//  BaseCoordinator.swift
//  Airports
//
//  Created by Maksim  on 09.10.2022.
//

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    func start() {
        fatalError("Children should implement 'start'.")
    }
    
 
}
