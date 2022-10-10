//
//  AirportService .swift
//  Airports
//
//  Created by Maksim  on 10.10.2022.
//

import RxSwift
import Alamofire
import Foundation

class AirportService {
    private lazy var httpService = AirportHttpService()
    static let shared: AirportService = AirportService()
}

extension AirportService: AirportApi {
    
    func fetchAirports() -> Single<AirportsResponse> {
        
        return Single.create { [self] (single) -> Disposable in
            do {
                try AirportHttpRouter.getAirports
                    .request(service: httpService)
                    .responseJSON(completionHandler: { result in
                        do {
                            let airports = try AirportService.parseAirports(result: result)
                            single(.success(airports))
                        } catch {
                            single(.failure(error))
                        }
                    })
            } catch {
                single(.failure(CustomError.error(message: "Airports fetch failed")))
            }
            
            return Disposables.create()
        }
    }
    
    
}

extension AirportService {
    
    static func parseAirports(result: AFDataResponse<Any>) throws -> AirportsResponse {
        guard let data = result.data,
              let airportsResponse = try? JSONDecoder().decode(AirportsResponse.self, from: data)
              else {
                  throw CustomError.error(message: "Invalid Airports JSON")
              }
        
        return airportsResponse
    }
    
}
