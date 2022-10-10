//
//  AirportApi.swift
//  Airports
//
//  Created by Maksim  on 10.10.2022.
//

import RxSwift

protocol AirportApi {
    func fetchAirports() -> Single<AirportsResponse>
}
