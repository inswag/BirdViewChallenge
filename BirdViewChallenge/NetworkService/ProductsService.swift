////
////  ProductsService.swift
////  BirdViewChallenge
////
////  Created by 박인수 on 10/01/2020.
////  Copyright © 2020 inswag. All rights reserved.
////
//
//import Foundation
//import Alamofire
//
//protocol ProductsServiceType {
//    func fetchProductsAllType(completion: @escaping (Result<ProductsAllTypeRoot>) -> ())
//    func fetchProductsByType(type: String, page: Int, completion: @escaping (Result<ProductsAllTypeRoot>) -> ())
//    func fetchProductsBySearchingInType(type: String, keyword: String, completion: @escaping (Result<ProductsAllTypeRoot>) -> ())
//}
//
//struct ProductsService: ProductsServiceType {
//
//
//    // 모든 피부 타입 (Pagination X)
//    func fetchProductsAllType(completion: @escaping (Result<ProductsAllTypeRoot>) -> ()) {
//        let api = "\(API.baseURL)" + "\(API.getProducts)"
//        Alamofire
//            .request(api, method: .get)
//            .validate()
//            .responseData { (response) in
//                switch response.result {
//                case .success(let value):
//                    do {
//                        let decodableValue = try JSONDecoder().decode(ProductsAllTypeRoot.self, from: value)
//                        completion(Result.success(decodableValue))
//                    } catch {
//                        completion(.failure(nil, error))
//                    }
//                case .failure(let error) :
//                    completion(.failure(response.data!, error))
//                }
//        }
//
//    }
//
//    // 피부 타입 유형에 따른 상품 (Pagination O)
//    func fetchProductsByType(type: String, page: Int = 1, completion: @escaping (Result<ProductsAllTypeRoot>) -> ()) {
//
//        let api = "\(API.baseURL)" + "\(API.getProducts)" + "\(API.skinTypeURL)" + "\(type)" + "\(API.pageURL)" + "\(page)"
//        Alamofire
//            .request(api, method: .get)
//            .validate()
//            .responseData { (response) in
//                switch response.result {
//                case .success(let value) :
//                    do {
//                        let decodableValue = try JSONDecoder().decode(ProductsAllTypeRoot.self, from: value)
//                        completion(Result.success(decodableValue))
//                        //                        print(decodableValue)
//                    } catch {
//                        completion(.failure(nil, error))
//                    }
//                case .failure(let error) :
//                    completion(.failure(response.data!, error))
//                }
//        }
//    }
//
//    func fetchProductsBySearchingInType(type: String, keyword: String, completion: @escaping (Result<ProductsAllTypeRoot>) -> ()) {
//
//        let api = "\(API.baseURL)" + "\(API.getProducts)" + "\(API.skinTypeURL)" + "\(type)" + "\(API.searchURL)" + "\(keyword)"
//        Alamofire
//            .request(api, method: .get)
//            .validate()
//            .responseData { (response) in
//                switch response.result {
//                case .success(let value) :
//                    do {
//                        let decodableValue = try JSONDecoder().decode(ProductsAllTypeRoot.self, from: value)
//                        completion(Result.success(decodableValue))
//                        //                        print(decodableValue)
//                    } catch {
//                        completion(.failure(nil, error))
//                    }
//                case .failure(let error) :
//                    completion(.failure(response.data!, error))
//                }
//        }
//    }
//
//}
