////
////  NetworkManager.swift
////  BirdViewChallenge
////
////  Created by 박인수 on 15/01/2020.
////  Copyright © 2020 inswag. All rights reserved.
////
//
//import Moya
//
//protocol Networkable {
//
//    var provider: MoyaProvider<BirdViewService> { get }
//
//    func fetchAllTypeProducts(completion: @escaping (ProductsRoot) -> ())
//
//}
//
//// Network Manager is a struct which is a value type.
//struct NetworkManager: Networkable {
//
//    // keep our provider private as we do not want anyone outside of this file to access the provider directly
//    internal let provider = MoyaProvider<BirdViewService>(plugins: [NetworkLoggerPlugin(verbose: true)])
//
//    func fetchAllTypeProducts(completion: @escaping (ProductsRoot) -> ()) {
//        provider.request(.allType) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    let results = try JSONDecoder().decode(ProductsRoot.self, from: response.data)
//                    completion(results)
//                } catch let err {
//                    print(err)
//                }
//            case let .failure(error):
//                print(error)
//            }
//        }
//    }
//
//    func fetchProducts(by skinType: String, page: Int, completion: @escaping (ProductsRoot) -> ()) {
//        provider.request(.productsByType(type: skinType, page: page)) { (result) in
//            switch result {
//            case let .success(response):
//                do {
//                    let results = try JSONDecoder().decode(ProductsRoot.self, from: response.data)
//                    completion(results)
//                } catch let err {
//                    print(err)
//                }
//            case let .failure(error):
//                print(error)
//            }
//        }
//    }
//
//    func fetchProductSelected(id: Int, completion: @escaping (ProductRoot) -> ()) {
//        provider.request(.productSelected(id: id)) { (result) in
//            switch result {
//            case let .success(response):
//                do {
//                    let results = try JSONDecoder().decode(ProductRoot.self, from: response.data)
//                    completion(results)
//                } catch let err {
//                    print(err)
//                }
//            case let .failure(error):
//                print(error)
//            }
//        }
//    }
//
//    func fetchProduct(by keyword: String, and skinType: String, completion: @escaping (ProductsRoot) -> ()) {
//        provider.request(.productsBySearch(type: skinType, keyword: keyword)) { (result) in
//            switch result {
//            case let .success(response):
//                do {
//                    let results = try JSONDecoder().decode(ProductsRoot.self, from: response.data)
//                    completion(results)
//                } catch let err {
//                    print(err)
//                }
//            case let .failure(error):
//                print(error)
//            }
//        }
//    }
//
//    
//}