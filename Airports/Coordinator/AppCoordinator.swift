//
//  AppCoordinator.swift
//  Airports
//
//  Created by Maksim  on 09.10.2022.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let router = Router(navigationController: self.navigationController)
        let searchCityCoordinator = SearchCityCoordinator(router: router)
        self.add(coordinator: searchCityCoordinator)
        searchCityCoordinator.isCompleted = { [weak self, weak searchCityCoordinator] in
            guard let coordinator = searchCityCoordinator else { return }
            self?.remove(coordinator: coordinator)
        }
        
        searchCityCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    
}
