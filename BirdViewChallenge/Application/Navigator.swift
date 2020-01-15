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
        case products(viewModel: ProductsControllerViewModel, provider: NetworkManager)           // Products
//        case product            // Product
    }
    
    func get(segue: Scene) -> UIViewController {
        
        switch segue {
        case .products(let viewModel, let provider):
            return NavigationController(rootViewController: ProductsController(viewModel: viewModel, navigator: self, provider: provider))
            //viewModel: viewModel, navigator: self)
//        case .product: return ProductViewController()
//        case .product:
//            <#code#>
        }
        
    }
}
