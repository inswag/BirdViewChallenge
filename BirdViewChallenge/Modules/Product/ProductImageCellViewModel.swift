//
//  ProductImageCellViewModel.swift
//  BirdViewChallenge
//
//  Created by Insu Park on 2020/01/27.
//  Copyright © 2020 inswag. All rights reserved.
//

import Foundation

import UIKit

class ProductImageCellViewModel {
    
    // MARK:- Properties

    let fullSizeImage: String
    
    init(content: Product) {
        self.fullSizeImage = content.fullSizeImage
    }

}
