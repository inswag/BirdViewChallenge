//
//  ViewController.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 06/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    

    // MARK:- Initialize
     
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIComponents()
        setupUILayout()
    }
    
    // MARK:- UI Methods

    
    func setupUIComponents() {
        
    }
    
    func setupUILayout() {
        
    }

    deinit {
        print("ok")
    }
}
