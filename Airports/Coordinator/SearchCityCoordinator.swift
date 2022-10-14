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
    
    private let router: Routing
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
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
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)

    }
}

private extension SearchCityCoordinator {
    
    func showAirports(models: Set<AirportModel>) {
        let airportsCoordinator = AirportsCoordinator(router: self.router, models: models)
        self.add(coordinator: airportsCoordinator)
        airportsCoordinator.isCompleted = { [ weak self, weak airportsCoordinator ] in
            guard let coordinator = airportsCoordinator else { return }
            self?.remove(coordinator: coordinator)
        }
        airportsCoordinator.start()
    }
    
}
