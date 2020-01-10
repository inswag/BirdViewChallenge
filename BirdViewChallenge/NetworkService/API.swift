//
//  API.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 10/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import Foundation

enum API {
    
    static let baseURL = "https://6uqljnm1pb.execute-api.ap-northeast-2.amazonaws.com/prod"
    
    // 피부타입이 주어지지 않으면, default로 지성 피부 성분 점수 순으로 상품 목록을 반환
    static let getProducts = "/products"
    
    // 지성 피부에 대한 성분 점수 내림차순으로 상품 목록을 반환 (20개 단위 페이징) Ref. 어차피 아래 page 를 1로 설정한 내용과 같다.
    static let skinTypeURL = "?skin_type="
    
    // 페이지 번호에 해당되는 상품 목록을 반환합니다. (20개 단위)
    static let pageURL = "&page="
    
    // 키워드에 해당되는 상품 목록을 반환합니다.
    static let searchURL = "&search="
}

enum Result<T> {
    case success(T)
    case failure(Data?, Error)
}
