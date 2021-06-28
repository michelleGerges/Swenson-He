//
//  ServerErrorResponse.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import Foundation
import ObjectMapper

class ServerErrorResponse: Mappable {
    
    var error: ServerError?
    
    func mapping(map: Map) {
        error <- map["error"]
    }
    
    required init?(map: Map) { }
}
