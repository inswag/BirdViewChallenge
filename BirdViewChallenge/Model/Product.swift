//
//  Product.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 10/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import Foundation

struct ProductRoot: Decodable {
    
    let body: Product
    
    enum CodingKeys: String, CodingKey {
        case body
    }
    
}

struct Product: Decodable {
    
    let id: Int                     // 상품 코드
    let fullSizeImage: String       // 상세 정보 이미지
    let title: String               // 상품명
    let description: String         // 상품 설명
    let price: String               // 상품 가격
    let oilyScore: Int?              // 지성 성분 점수
    let dryScore: Int?               // 건성 성분 점수
    let sensitiveScore: Int?         // 민감성 성분 점수
    
    enum CodingKeys: String, CodingKey {
        case fullSizeImage = "full_size_image"
        case oilyScore = "oily_score"
        case dryScore = "dry_score"
        case sensitiveScore = "sensitive_score"
        case id, title, description, price
    }
    
}
