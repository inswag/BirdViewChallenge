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
    
    let productsService: ProductsService = ProductsService()
    var fetchedProducts: [ProductsAllType] = []
    var page: Int = 1
    
    // PickerView Property
    let typeArray = ["모든 피부 타입", "지성", "건성", "민감성"]
    
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
    
    // MARK:- Methods
    
    func fetchAllTypeProducts(completion: @escaping () -> Void) {
        productsService.fetchProductsAllType { (result) in
            switch result {
            case .success(let value):
                value.body.forEach { self.fetchedProducts.append($0) }
                completion()
            case .failure(let error):
                print(error)
                //                self.since = 0
            }
        }
    }
    
}
