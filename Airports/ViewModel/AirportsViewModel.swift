//
//  AirportsViewModel.swift
//  Airports
//
//  Created by Maksim  on 13.10.2022.
//

import Foundation

protocol AirportsViewPresentable {
    
    typealias Output = ()
    typealias Input = ()
    
    var output: AirportsViewPresentable.Output { get }
    var input: AirportsViewPresentable.Input { get }
}

struct AirportsViewModel: AirportsViewPresentable  {
    
    var output: AirportsViewPresentable.Output
    var input: AirportsViewPresentable.Input

}
