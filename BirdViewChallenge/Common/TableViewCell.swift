//
//  TableViewCell.swift
//  BirdViewChallenge
//
//  Created by Insu Park on 2020/03/08.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK:- Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUIComponents()
        setupUILayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Methods
    
    func setupUIComponents() {
        
    }
    
    func setupUILayout() {
        
    }
}
