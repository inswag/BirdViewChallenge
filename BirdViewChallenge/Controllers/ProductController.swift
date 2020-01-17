//
//  ProductController.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 17/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import SnapKit

class ProductController: ViewController {
    
    let navigate: Navigator
    
    // MARK:- Initialize
    
    init(navigator: Navigator) { // viewModel: ProductsControllerViewModel, navigator: Navigator, provider: NetworkManager
//        self.viewModel = viewModel
//        self.provider = provider
        self.navigate = navigator
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:- UI Method

    override func setupUIComponents() {
        self.view.backgroundColor = .black
    }
    
    
    
}
