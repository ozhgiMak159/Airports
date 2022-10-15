//
//  AirportsCoordinator.swift
//  Airports
//
//  Created by Maksim  on 13.10.2022.
//

import UIKit
import RxSwift

class AirportsCoordinator: BaseCoordinator {
    
    private let router: Routing
    private let models: Set<AirportModel>
    private let bag = DisposeBag()
    
    init(router: Routing, models: Set<AirportModel>) {
        self.models = models
        self.router = router
    }
    
    override func start() {
        let view = AirportsViewController.instantiate()
        let locationService = LocationService.shared
        
        view.viewModelBuilder = { [models, locationService, bag] in
            let title = models.first?.city ?? ""
            var viewModel = AirportsViewModel(input: $0,
                                     dependencies: (
                                        title: title,
                                        models: models,
                                        currentLocation: locationService.currentLocation
                                     )
            )
            
            viewModel.router.airportSelect
                .map { [weak self] model in
                    self?.showAirportDetails(model: model)
            }
            .drive()
            .disposed(by: bag)
            return viewModel
        }
        
        self.router.push(view, isAnimated: true, onNavigationBack: isCompleted)
        
    }
}

private extension AirportsCoordinator {
    
    func showAirportDetails(model: AirportModel) {
        let detailsCoordinator = AirportDetailsCoordinator(router: self.router)
        self.add(coordinator: detailsCoordinator)
        detailsCoordinator.isCompleted = { [weak self, weak detailsCoordinator] in
            guard let detailsCoordinator = detailsCoordinator else { return }
            self?.remove(coordinator: detailsCoordinator)
        }
        detailsCoordinator.start()
    }
    
    
}
