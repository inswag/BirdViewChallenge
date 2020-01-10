//
//  Products.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 10/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import Foundation

struct ProductsRoot: Decodable {
    
    let body: [Products]
    
    enum CodingKeys: String, CodingKey {
        case body
    }
    
}

struct Products: Decodable {
    
    let id: Int
    let thumbnail: String
    let title: String
    let price: String
    let oilyScore: Int
    let dryScore: Int
    let sensitiveScore: Int
    
    enum CodingKeys: String, CodingKey {
        
        case thumbnail = "thumbnail_image"
        case oilyScore = "oily_score"
        case dryScore = "dry_score"
        case sensitiveScore = "sensitive_score"
        case id, title, price
    }
    
}
