//
//  SearchCityCoordinator.swift
//  Airports
//
//  Created by Maksim  on 09.10.2022.
//

import UIKit
import RxSwift
import RxCocoa

class SearchCityCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController
    private let bag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let view = SearchCityAirportsViewController.instantiate()
        let service = AirportService.shared
        
        view.viewModelBuilder = { [bag] in
            let viewModel = SearchCityViewModel(input: $0, airportService: service)
            viewModel.router.citySelected
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.showAirports(models: $0)
                })
                .drive()
                .disposed(by: bag)
            
            return viewModel
        }
        
        navigationController.pushViewController(view, animated: true)

    }
}

private extension SearchCityCoordinator {
    
    func showAirports(models: Set<AirportModel>) {
        let airportsCoordinator = AirportsCoordinator(navigationController: self.navigationController)
        self.add(coordinator: airportsCoordinator)
        airportsCoordinator.start()
    }
    
}
