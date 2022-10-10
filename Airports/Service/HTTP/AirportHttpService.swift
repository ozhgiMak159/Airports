//
//  AirportHttpService.swift
//  Airports
//
//  Created by Maksim  on 10.10.2022.
//

import Alamofire

class AirportHttpService: HttpService {
    
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
    
    
}
