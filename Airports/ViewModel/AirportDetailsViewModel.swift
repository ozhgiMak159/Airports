//
//  AirportDetailsViewModel.swift
//  Airports
//
//  Created by Maksim  on 15.10.2022.
//


import RxSwift
import RxCocoa

protocol AirportDetailsViewPresentable {
    
    typealias Input = ()
    typealias Output = (
        airportDetails: Driver<AirportViewPresentable>, ()
    )
    typealias Dependencies = (
        model: AirportModel,
        currentLocation: Observable<(lat: Double, lon: Double)?>
    )
    
    var input: AirportDetailsViewPresentable.Input { get }
    var output: AirportDetailsViewPresentable.Output { get }
    
    typealias ViewModelBuilder = (AirportDetailsViewPresentable.Input) -> AirportDetailsViewPresentable
}


 class AirportDetailsViewModel: AirportDetailsViewPresentable {
    var input: AirportDetailsViewPresentable.Input
    var output: AirportDetailsViewPresentable.Output
    
    
    init(input: AirportDetailsViewPresentable.Input, dependencies: AirportDetailsViewPresentable.Dependencies) {
        self.input = input
        self.output = AirportDetailsViewModel.output(input: self.input,
                                                     dependencies: dependencies)
    }

}


private extension AirportDetailsViewModel {
    
    static func output(input: AirportDetailsViewPresentable.Output,
                       dependencies:AirportDetailsViewPresentable.Dependencies) -> AirportDetailsViewPresentable.Output {
        
        let airportDetails: Driver<AirportViewPresentable> = dependencies.currentLocation
            .filter({ $0 != nil })
            .map({ $0! })
            .map({ [airportModel = dependencies.model] currentLocation in
                AirportViewModel(model: airportModel, currentLocation: currentLocation)
            })
            .asDriver(onErrorDriveWith: .empty())
        
        return (
            airportDetails: airportDetails, ()
        )
    }
    
}
