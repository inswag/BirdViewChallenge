//
//  NumberFormatter.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 20/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import Foundation

extension Tools {
    
    static func numberFormatter(stringNumber: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let stringToInt = Int(stringNumber) else { return "ERROR: String To Int" }
        let formatting = NSNumber(value: stringToInt)
        guard let convertToString = numberFormatter.string(from: formatting) else { return "ERROR: Convert To String" }
        return convertToString
    }
    
}
