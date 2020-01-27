//
//  ProductDescriptionCellViewModel.swift
//  BirdViewChallenge
//
//  Created by Insu Park on 2020/01/27.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

class ProductDescriptionCellViewModel {
    
    // MARK:- Properties

    let description: String
    
    init(content: Product) {
        self.description = content.description
    }

}
