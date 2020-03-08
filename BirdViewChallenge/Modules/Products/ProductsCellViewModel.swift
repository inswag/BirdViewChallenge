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
    let oilyScore: Int?
    let dryScore: Int?
    let sensativeScore: Int?
    let thumbnail: String
    let title: String
    
    // MARK:- Initialize
    
    init(content: Products) {
        self.id = content.id
        self.price = content.price
        self.oilyScore = content.oilyScore
        self.dryScore = content.dryScore
        self.sensativeScore = content.sensativeScore
        self.thumbnail = content.thumbnail
        self.title = content.title
    }

}
