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
    
    // MARK:- Cell Type
    
    enum CellType: Int {
        case image
        case tag
        case description
        case totalCount
    }
    
    // MARK:- Properties
    
    var fetchedProduct: Product?
    var id: Int
    let provider = MoyaProvider<BirdViewRouter>()
    
    // MARK:- Initialize
    
    init(id: Int) {
        self.id = id
    }
    
    // MARK:- Network Methods
    
    func fetchProductSelected(id: Int, completion: @escaping () -> ()) {
        provider.request(.productSelected(id: id)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(ProductRoot.self, from: response.data)
                    self?.fetchedProduct = results.body
                    completion()
                } catch let err {
                    print(err)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK:- Table View Methods
    
    func numberOfRowsInSection() -> Int {
        return ProductControllerViewModel.CellType.totalCount.rawValue
    }
    
    
    
}
