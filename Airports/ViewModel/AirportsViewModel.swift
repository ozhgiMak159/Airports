//
//  AirportsViewModel.swift
//  Airports
//
//  Created by Maksim  on 13.10.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

typealias AirportItemSection = SectionModel<Int, AirportViewPresentable>

protocol AirportsViewPresentable {
    
    typealias Output = (
        title: Driver<String>,
        airports: Driver<[AirportItemSection]>
    )
    
    typealias Input = ()
    
    typealias Dependencies = (
        title: String,
        models: Set<AirportModel>
    )
    
    typealias ViewModelBuilder = (AirportsViewPresentable.Input) -> AirportsViewPresentable
    
    var output: AirportsViewPresentable.Output { get }
    var input: AirportsViewPresentable.Input { get }
}

struct AirportsViewModel: AirportsViewPresentable  {
    
    var output: AirportsViewPresentable.Output
    var input: AirportsViewPresentable.Input
    
    init(input: AirportsViewPresentable.Input, dependencies: AirportsViewPresentable.Dependencies) {
        self.input = input
        self.output = AirportsViewModel.output(dependencies: dependencies)
    }

}

private extension AirportsViewModel {
    
    static func output(dependencies: AirportsViewPresentable.Dependencies) -> AirportsViewPresentable.Output {
        
        let sections = Driver.just(dependencies.models)
            .map { $0.compactMap({ AirportViewModel(model: $0)}) }
            .map({ [AirportItemSection(model: 0, items: $0)] })
        
        return (
            title: Driver.just(dependencies.title),
            airports: sections
        )
    }
    
    
}
