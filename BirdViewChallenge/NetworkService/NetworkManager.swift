//
//  NetworkManager.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 15/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import Moya

protocol Networkable {
    
    var provider: MoyaProvider<BirdViewApi> { get }
    
    func fetchAllTypeProducts(completion: @escaping (ProductsAllTypeRoot) -> ())
    
}

// Network Manager is a struct which is a value type.
struct NetworkManager: Networkable {
    
    // keep our provider private as we do not want anyone outside of this file to access the provider directly
    internal let provider = MoyaProvider<BirdViewApi>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func fetchAllTypeProducts(completion: @escaping (ProductsAllTypeRoot) -> ()) {
        provider.request(.allType) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(ProductsAllTypeRoot.self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
}
