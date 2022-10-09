//
//  SearchCityCoordinator.swift
//  Airports
//
//  Created by Maksim  on 09.10.2022.
//

import UIKit

class SearchCityCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let view = SearchCityAirportsViewController.instantiate()
        view.viewModelBuilder = {
            SearchCityViewModel(input: $0)
        }
        
        navigationController.pushViewController(view, animated: true)

    }
}
