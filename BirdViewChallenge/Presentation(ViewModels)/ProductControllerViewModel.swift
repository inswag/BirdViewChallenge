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
    var fetchedProduct: Product?
    var id: Int
    
    // MARK:- Initialize
    
    init(provider: NetworkManager, id: Int) {
        self.provider = provider
        self.id = id
    }
    
    // MARK:-
    
    
    
    // MARK:- Methods
    
    func fetchProductSelected(id: Int, completion: @escaping () -> ()) {
        provider.fetchProductSelected(id: id) { (response) in
            self.fetchedProduct = response.body
            completion()
        }
    }
    
}
