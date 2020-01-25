//
//  ProductControllerViewModel.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 19/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import Moya

final class ProductControllerViewModel {
    
    // MARK:- Properties
    
    var fetchedProduct: Product?
    var id: Int
    let provider = MoyaProvider<BirdViewService>()
    
    // MARK:- Initialize
    
    init(id: Int) {
        self.id = id
    }
    
    // MARK:-
    
    
    
    // MARK:- Methods
    
    func fetchProductSelected(id: Int, completion: @escaping () -> ()) {
//        provider.fetchProductSelected(id: id) { (response) in
//            self.fetchedProduct = response.body
//            completion()
//        }
    }
    
}
