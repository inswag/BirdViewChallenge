//
//  Font.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 06/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

struct Font {
    
    // Tools.font.appleSDGothicNeoRegular(size: <#입력#>)
    func appleSDGothicNeoRegular(size: CGFloat) -> UIFont {
        return UIFont.init(name: "AppleSDGothicNeo-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // Tools.font.appleSDGothicNeoBold(size: <#입력#>)
    func appleSDGothicNeoBold(size: CGFloat) -> UIFont {
        return UIFont.init(name: "AppleSDGothicNeo-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // Tools.font.appleSDGothicNeoBold(size: <#입력#>)
    func notoSansCJKkrBlack(size: CGFloat) -> UIFont {
        return UIFont.init(name: "NotoSansCJKkr-Black", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // Tools.font.appleSDGothicNeoBold(size: <#입력#>)
    func notoSansCJKkrBold(size: CGFloat) -> UIFont {
        return UIFont.init(name: "NotoSansCJKkr-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}
