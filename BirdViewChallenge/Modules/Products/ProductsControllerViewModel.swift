//
//  ProductsControllerViewModel.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 08/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import Moya

final class ProductsControllerViewModel {
    
    // MARK:- Properties
    
    var fetchedProducts: [Products] = []
    var page: Int = 1
    let provider = MoyaProvider<BirdViewService>()
    var pagenationPermission: Bool = true
    
    // PickerView Property
    let typeArray = ["모든 피부 타입", "지성", "건성", "민감성"]
    
    enum Types: Int {
        case `default`
        case oily
        case dry
        case sensitive
    }
    
    // MARK:- Initialize
    
    init() {
    
    }
    
    // MARK:- Data Source
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection() -> Int {
        return self.fetchedProducts.count
    }
    
    // MARK:- Network Methods
    
    func fetchAllTypeProducts(completion: @escaping () -> ()) {
        provider.request(.allType) { (result) in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(ProductsRoot.self, from: response.data)
                    results.body.forEach { self.fetchedProducts.append($0) }
                    completion()
                } catch let err {
                    print(err)
                }
            case .failure(let error):
                print(error)
            }
        }
        
        pagenationPermission = false
    }

    func fetchProducts(by skinType: String, page: Int = 1, completion: @escaping () -> ()) {
        
        pagenationPermission = true
        
        provider.request(.productsByType(type: skinType, page: page)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(ProductsRoot.self, from: response.data)
                    results.body.forEach { self.fetchedProducts.append($0) }
                    completion()
                } catch let err {
                    print(err)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchMoreProducts(skinType: String, indexPath: IndexPath, completion: @escaping () -> ()) {
        
        if pagenationPermission == false {
            print("Pagination Permission is denied")
            return
        }
        
        if indexPath.row == fetchedProducts.count - 1 {
            self.page += 1
            print(self.page)
            
            provider.request(.productsByType(type: skinType, page: page)) { (result) in
                switch result {
                case .success(let response):
                    do {
                        let results = try JSONDecoder().decode(ProductsRoot.self, from: response.data)
                        results.body.forEach { self.fetchedProducts.append($0) }
                        completion()
                    } catch let err {
                        print(err)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func fetchProducts(by search: String, and skinType: String, completion: @escaping () -> ()) {
        
        pagenationPermission = false
        
        provider.request(.productsBySearch(type: skinType, search: search)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(ProductsRoot.self, from: response.data)
                    results.body.forEach { self.fetchedProducts.append($0) }
                    print("result: \(result)")
                    completion()
                } catch let err {
                    print(err)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
