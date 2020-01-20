//
//  ProductCellViewModel.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 19/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

class ProductCellViewModel {
    
    // MARK:- Properties

    let dryScore: Int?
    let fullSizeImage: String
    let oilyScore: Int?
    let sensitiveScore: Int?
    let description: String
    let id: Int
    let price: String
    let title: String
    
    init(content: Product) {
        self.dryScore = content.dryScore
        self.fullSizeImage = content.fullSizeImage
        self.oilyScore = content.oilyScore
        self.sensitiveScore = content.sensitiveScore
        self.description = content.description
        self.id = content.id
        self.price = content.price
        self.title = content.title
    }

}
