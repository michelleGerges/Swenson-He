//
//  SymbolsResponse.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import Foundation
import ObjectMapper

class SymbolsResponse: Mappable {
    
    var success: Bool?
    var symbols: [String: String]?
    
    func mapping(map: Map) {
        success <- map["success"]
        symbols <- map["symbols"]
    }
    
    required init?(map: Map) { }
}

extension SymbolsResponse: Successable {
    
    var isSuccess: Bool {
        return success ?? false
    }
}
