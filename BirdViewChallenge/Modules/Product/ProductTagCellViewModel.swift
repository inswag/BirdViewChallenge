//
//  ProductTagCellViewModel.swift
//  BirdViewChallenge
//
//  Created by Insu Park on 2020/01/27.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

class ProductTagCellViewModel {
    
    // MARK:- Properties

    let price: String
    let title: String
    
    init(content: Product) {
        self.price = content.price
        self.title = content.title
    }

}
