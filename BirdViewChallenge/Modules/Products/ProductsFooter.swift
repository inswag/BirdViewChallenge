//
//  ProductsFooter.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 09/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

class ProductsFooter: UICollectionReusableView {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .clear
        iv.image = UIImage(named: "compass_black")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUIComponents() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { (m) in
            m.width.equalTo(24)
            m.height.equalTo(24)
            m.centerX.equalToSuperview()
            m.centerY.equalToSuperview()
        }
    }
    
}
