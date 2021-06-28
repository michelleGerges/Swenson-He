//
//  MoyaProvider+Promise.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import Alamofire
import Moya
import PromiseKit
import Moya_ObjectMapper
import ObjectMapper

protocol Successable {
    var isSuccess: Bool { get }
}

extension MoyaProvider {
    
    func requestPromise<T: Mappable & Successable> (_ target: Target) -> Promise<T> {
        
        return Promise<T> { (resolver) in
            
            self.request(target) { (result) in
                
                switch result {
                    
                case let .success(response):
                    
                    do {
                        if response.isSuccess { // response status code is 200
                            
                            let serverResponse = try response.mapObject(T.self)
                            
                            if serverResponse.isSuccess {
                                resolver.fulfill(serverResponse)
                            } else {
                                // Map to error Object
                                let errorResponse = try response.mapObject(ServerErrorResponse.self)
                                resolver.reject(ErrorHandler.serverError(error: errorResponse.error))
                            }
                            
                        } else { // response status code is 400 ... 500
                            let errorResponse = try response.mapObject(ServerErrorResponse.self)
                            resolver.reject(ErrorHandler.serverError(error: errorResponse.error))
                        }
                        
                    } catch { // could not serialization
                        resolver.reject(ErrorHandler.serialization)
                    }
                    
                case .failure:
                    resolver.reject(ErrorHandler.network)
                }
            }
        }
    }
}

extension Moya.Response {
    var isSuccess: Bool {
        return (200 ... 299) ~= self.statusCode
    }
    
    var isAppTokenExpired: Bool {
        return self.statusCode == 401
    }
}

extension NetworkLoggerPlugin.Configuration {
    
    static var loggerConfiguration: NetworkLoggerPlugin.Configuration {
        return NetworkLoggerPlugin.Configuration (formatter: Formatter (),
                                                  output: defaultOutput(target:items:),
                                                  logOptions: LogOptions.verbose)
    }
}

extension NetworkLoggerPlugin {
    
    static var networkLogger: NetworkLoggerPlugin {
        return NetworkLoggerPlugin (configuration: NetworkLoggerPlugin.Configuration.loggerConfiguration)
    }
}
