//
//  Response.swift
//  RickAndMorty
//
//  Created by Gleb on 11.05.2023.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    
    let results: T
}
