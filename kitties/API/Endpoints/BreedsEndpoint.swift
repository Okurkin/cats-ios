//
//  BreedsEndpoint.swift
//  kitties
//
//  Created by Okurkin on 06.06.2023.
//

import Foundation

struct BreedsEndpoint: Endpoint {
    var path: String = "breeds"
    
    var headers: [String: String] {
            return [
                HTTPHeader.HeaderField.contentType.rawValue: HTTPHeader.ContentType.json.rawValue,
                HTTPHeader.HeaderField.apiKey.rawValue: Constants.apiKey
            ]
        }
    
}
