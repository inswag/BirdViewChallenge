//
//  NavigationController.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 06/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    // MARK:- Initialize
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIComponents()
    }
    
    // MARK:- Methods
    func setupUIComponents() {
        self.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationBar.barTintColor = UIColor.colorWithHexString(hexString: "#9013FE")
    }
    
}
