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
        if self.fetchedProducts.count != 0 { self.fetchedProducts.removeAll() }
        provider.fetchAllTypeProducts { (response) in
            response.body.forEach { self.fetchedProducts.append($0) }
            completion()
        }
        
    }
    
    func fetchProductsByType(skinType: String, page: Int = 1, completion: @escaping () -> ()) {
        provider.fetchProductsByType(skinType: skinType, page: page) { (response) in
            self.fetchedProducts.removeAll()
            response.body.forEach { self.fetchedProducts.append($0) }
            completion()
        }
    }
    
//    var page = 2
    
    func paginateProducts(skinType: String) {
        //        print("will Paginate User List!")
        //        print("pageNumber: ", page)
        //        fetchProducts(since: page)
        
//        provider.fetchProductsByType(skinType: skinType, page: page) { (response) in
//            response.body.forEach { self.fetchedProducts.append($0) }
//            self.page += 1
//            print(self.page)
//        }
    }
    
}
