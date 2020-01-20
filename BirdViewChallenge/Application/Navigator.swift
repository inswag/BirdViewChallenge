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
        case products // Products
        case product(id: Int) // Product
    }
    
    func get(segue: Scene) -> UIViewController {
        switch segue {
        case .products:
            let viewModel = ProductsControllerViewModel(provider: NetworkManager())
            let productsVC = ProductsController(viewModel: viewModel, navigator: self)
            productsVC.modalPresentationStyle = .fullScreen
            let naviProducts = NavigationController(rootViewController: productsVC)
            return naviProducts
        case .product(let id):
            let viewModel = ProductControllerViewModel(provider: NetworkManager(), id: id)
            let productVC = ProductController(viewModel: viewModel, navigator: self)
            productVC.modalPresentationStyle = .overCurrentContext
            return productVC
        }
    }
}
