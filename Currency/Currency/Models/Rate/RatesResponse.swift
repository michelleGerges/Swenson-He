//
//  RatesResponse.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import Foundation
import ObjectMapper

class RatesResponse: Mappable {
    
    var success: Bool?
    var base: String?
    var rates: [String: Double]?
    
    func mapping(map: Map) {
        success <- map["success"]
        base <- map["base"]
        rates <- map["rates"]
    }
    
    required init?(map: Map) { }
}

extension RatesResponse: Successable {
    
    var isSuccess: Bool {
        return success ?? false
    }
}
