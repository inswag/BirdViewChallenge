//
//  Color.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 06/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

struct Color {
    
    // Ref. Navigation Bar Background Color
    var violet: String {
        return "#9013FE"
    }
    
    // Ref. Product Name
    var lightBlack: String {
        return "#141428"
    }
    
    var whiteAndBlack: String {
        return "#A3A3B5"
    }
    
    // Ref. Product Price
    var darkGray: String {
        return "#ABABC4"
    }
    
    var grayWhite: String {
        return "#ECECF5"
    }
    
    // Ref. product description
    var lightWhite: String {
        return "#F6F6FA"
    }
    
    // Ref. UIColor.black
    var black: String {
        return "#000000"
    }
    
    // Ref. Product Image Layer Color
    var lightGray: CGColor {
        return UIColor.rgb(r: 24, g: 24, b: 80, a: 0.04).cgColor
    }
    
    
}

extension UIColor {
    
    static func rgb(r red: CGFloat, g green: CGFloat, b blue: CGFloat, a alpha: CGFloat = 1.0) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func colorWithHexString(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        // Convert hex string to an integer
        var hexInt: UInt64 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexString)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt64(&hexInt)
        
        let red = CGFloat((hexInt & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexInt & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexInt & 0xff) >> 0) / 255.0
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }

}
