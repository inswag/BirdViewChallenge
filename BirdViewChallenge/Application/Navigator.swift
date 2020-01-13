//
//  Navigator.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 06/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

class Navigator {
    
//    static var `default` = Navigator()
    
    // MARK: - segues list, all app scenes
    enum Scene {
        case products(viewModel: ProductsControllerViewModel)           // Products
//        case product            // Product
    }
    
    func get(segue: Scene) -> UIViewController {
        
        switch segue {
        case .products(let viewModel):
            return NavigationController(rootViewController: ProductsController(viewModel: viewModel,
                                                                                   navigator: self))
            //viewModel: viewModel, navigator: self)
//        case .product: return ProductViewController()
//        case .product:
//            <#code#>
        }
        
    }
}
