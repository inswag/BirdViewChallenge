//
//  ProductsControllerViewModel.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 08/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

final class ProductsControllerViewModel {
    
    // MARK:- Properties
    
    let provider: NetworkManager
    var fetchedProducts: [Products] = []
    var page: Int = 1
    
    
    // PickerView Property
    let typeArray = ["모든 피부 타입", "지성", "건성", "민감성"]
    
    enum Types: Int {
        case `default`
        case oily
        case dry
        case sensitive
    }
    
    // MARK:- Initialize
    
    init(provider: NetworkManager) {
        self.provider = provider
    }
    
    // MARK:- Data Source
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection() -> Int {
        return self.fetchedProducts.count
    }
    
    // MARK:- Methods
    
    func fetchAllTypeProducts(completion: @escaping () -> ()) {
        provider.fetchAllTypeProducts { response in
            response.body.forEach { self.fetchedProducts.append($0) }
            completion()
        }
    }
    
    func fetchProducts(by skinType: String, page: Int = 1, completion: @escaping () -> ()) {
        provider.fetchProducts(by: skinType, page: page) { (response) in
            response.body.forEach { self.fetchedProducts.append($0) }
            completion()
        }
    }
    
    func fetchMoreProducts(skinType: String, indexPath: IndexPath, completion: @escaping () -> ()) {
        if indexPath.row == fetchedProducts.count - 1 {
            self.page += 1
            print(self.page)
            provider.fetchProducts(by: skinType, page: page) { (response) in
                response.body.forEach { self.fetchedProducts.append($0) }
                completion()
            }
        }
    }
    
    func fetchProducts(by keyword: String, and skinType: String, completion: @escaping () -> ()) {
        provider.fetchProduct(by: keyword, and: skinType) { (response) in
            response.body.forEach {
                self.fetchedProducts.append($0)
                completion()
            }
        }
        
    }
    
}
