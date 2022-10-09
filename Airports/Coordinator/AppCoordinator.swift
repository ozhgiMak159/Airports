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
        let searchCityCoordinator = SearchCityCoordinator(navigationController: navigationController)
        self.add(coordinator: searchCityCoordinator)
        searchCityCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    
}
