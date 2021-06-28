//
//  ServerError.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import Foundation
import ObjectMapper

class ServerError: Mappable {
    
    var code: Int?
    var info: String?
    var type: String?
    
    func mapping(map: Map) {
        code <- map["code"]
        info <- map["info"]
        type <- map["type"]
    }
    
    required init?(map: Map) { }
}
