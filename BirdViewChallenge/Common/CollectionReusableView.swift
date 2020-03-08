//
//  CollectionReusableView.swift
//  BirdViewChallenge
//
//  Created by Insu Park on 2020/03/08.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    
    // MARK:- Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIComponents()
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Methods
    
    func setupUIComponents() -> Void {
        
    }
    
    func setupUILayout() -> Void {
        
    }
}
