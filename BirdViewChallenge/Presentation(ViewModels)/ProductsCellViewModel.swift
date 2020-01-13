//
//  ProductsCellViewModel.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 08/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

class ProductsCellViewModel {
    
    // MARK:- Properties

    let id: Int
    let price: String
    let oilyScore: Int
    let thumbnail: String
    let title: String
    
    init(content: ProductsAllType) {
        self.id = content.id
        self.price = content.price
        self.oilyScore = content.oilyScore
        self.thumbnail = content.thumbnail
        self.title = content.title
    }

}
