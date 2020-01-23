//
//  BirdView.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 15/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import Moya

public enum BirdViewApi {
    
    // Products
    case allType
    case productsByType(type: String, page: Int)
    case productsBySearch(type: String, keyword: String)
    
    // Product
    case productSelected(id: Int)
    
}

extension BirdViewApi: TargetType {
    
    // 1
    public var baseURL: URL {
        return URL(string: "https://6uqljnm1pb.execute-api.ap-northeast-2.amazonaws.com/prod")!
    }
    
    // 2
    public var path: String {
        switch self {
        case .productSelected(let id):
            return "/products/\(id)"
        default:
            return "/products"
        }
    }
    
    // 3
    // Use Moya.Method as sometimes Xcode cannot find the Method namespace.
    public var method: Moya.Method {
        switch self {
        case .allType, .productsByType, .productsBySearch, .productSelected :
            return .get
        }
    }
    
    // 4
    public var sampleData: Data {
        return Data()
    }
    
    // 5 - Parameter 에 대한 처리가 들어가야함.
    public var task: Task {
        switch self {
        case .allType:
            return .requestPlain
        case .productsByType(let type, let page):
            return .requestParameters(parameters: ["skin_type": type, "page": page], encoding: URLEncoding.default)
        case .productsBySearch(let type, let keyword):
            return .requestParameters(parameters: ["keyword": keyword, "skin_type": type], encoding: URLEncoding.queryString)
        case .productSelected:
            return .requestPlain
        }
    }
    
    // 6
    public var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "token" : "46ea3a2703c54d1bc6ebbc366d0019f1"
        ]
    }
    
    
    // 7
    public var validationType: ValidationType {
        return .successCodes
    }
    
    
}

// just for convenience
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
