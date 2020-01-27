//
//  BirdView.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 15/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import Moya

public enum BirdViewService {
    
    // Products
    case allType
    case productsByType(type: String, page: Int)
    case productsBySearch(type: String, keyword: String)
    
    // Product
    case productSelected(id: Int)
    
}

// MARK: - TargetType Protocol Implementation
extension BirdViewService: TargetType {
    
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
    
    // 3 : Use 'Moya.Method' as sometimes Xcode cannot find the Method namespace.
    public var method: Moya.Method {
        switch self {
        case .allType, .productsByType, .productsBySearch, .productSelected :
            return .get
        }
    }
    
    // 4 : Use for Unit Test
    public var sampleData: Data {
        switch self {
        case .allType:
            return Data()
        case .productsByType(let type, let page):
            return "{'type': '\(type)', 'page': '\(page)'}".utf8Encoded
            case .productsBySearch(let type, let keyword):
                return "{'type': '\(type)', 'keyword': '\(keyword)'}".utf8Encoded
            case .productSelected(let id):
                return "{'id': '\(id)'}".utf8Encoded
        }
    }
    
    // 5 - Parameter 에 대한 처리가 들어간다.
    public var task: Task {
        switch self {
        case .allType: // Send no parameters
            return .requestPlain
        case let .productsByType(type, page): // Always sends parameters in URL, regardless of which HTTP method is used
            return .requestParameters(parameters: ["skin_type": type, "page": page], encoding: URLEncoding.queryString)
        case let .productsBySearch(type, keyword): // .JSON.. : Always send parameters as JSON in request body
            return .requestParameters(parameters: ["keyword": keyword, "skin_type": type], encoding: URLEncoding.queryString)
        case .productSelected: // Send no parameters
            return .requestPlain
        }
    }
    
    // 6 "token" : "46ea3a2703c54d1bc6ebbc366d0019f1"
    public var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    // 7
    public var validationType: ValidationType {
        return .successCodes
    }
    
}

// Just for convenience
private extension String {
    
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    
}
