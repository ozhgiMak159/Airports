//
//  HttpService.swift
//  Airports
//
//  Created by Maksim  on 10.10.2022.
//

import Alamofire

protocol HttpService {
    var sessionManager: Session { get set }
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest
}
