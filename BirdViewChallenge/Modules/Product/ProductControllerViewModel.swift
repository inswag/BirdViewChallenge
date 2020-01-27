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
    
    // MARK:- Network Methods
    
    func fetchProductSelected(id: Int, completion: @escaping () -> ()) {
        provider.request(.productSelected(id: id)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(ProductRoot.self, from: response.data)
                    self.fetchedProduct = results.body
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
