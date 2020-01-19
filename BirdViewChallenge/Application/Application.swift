//
//  Application.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 06/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

final class Application: NSObject {
    
    static let shared = Application()
    
    var window: UIWindow?
    var navigator: Navigator
    
    
    private override init() {
        self.navigator = Navigator()
        super.init()
    }
    
    func presentInitialScreen(in window: UIWindow) {
        self.window = window
        
        window.rootViewController = self.navigator.get(segue: .products)
    }
}
