//
//  ProductControllerViewModel.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 19/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

final class ProductControllerViewModel {
    
    // MARK:- Properties
    
    let provider: NetworkManager
    var fetchedProduct: [Product] = []
    var id: Int
    
    
    // PickerView Property
    let typeArray = ["모든 피부 타입", "지성", "건성", "민감성"]
    
    enum Types: Int {
        case `default`
        case oily
        case dry
        case sensitive
    }
    
    // MARK:- Initialize
    
    init(provider: NetworkManager, id: Int) {
        self.provider = provider
        self.id = id
    }
    
    // MARK:- Data Source
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection() -> Int {
        return self.fetchedProduct.count
    }
    
    // MARK:- Methods
}
