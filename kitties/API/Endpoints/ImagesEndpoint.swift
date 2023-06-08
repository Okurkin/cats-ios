//
//  ImagesEndpoint.swift
//  kitties
//
//  Created by Okurkin on 08.06.2023.
//

import Foundation


struct ImagesEndpoint: Endpoint {
    var path: String = "images/search"
    var breedId: String
    
    var headers: [String: String] {
            return [
                HTTPHeader.HeaderField.contentType.rawValue: HTTPHeader.ContentType.json.rawValue,
                HTTPHeader.HeaderField.apiKey.rawValue: Constants.apiKey
            ]
        }
    
    var urlParameters: [String: String] {
        return [
            "limit" : "\(Constants.galleryNumberOfImages)",
                 "breed_ids": self.breedId
        ]
    }
    
    init(breedId: String) {
        
        self.breedId = breedId
    }
}
