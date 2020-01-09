//
//  ProductsHeader.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 09/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

class ProductsHeader: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "baseline_navigation_black")
        return imgView
    }()
    
    let typeName: UILabel = {
        let label = UILabel()
        label.text = "타입"
        label.font = Tools.font.appleSDGothicNeoBold(size: 14)
        label.textColor = UIColor.colorWithHexString(hexString: Tools.color.black)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.setupUIComponents()
//        self.imageView.rotate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUIComponents() {
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (m) in
            m.width.equalTo(20)
            m.height.equalTo(20)
            m.centerX.equalToSuperview()
            m.centerY.equalToSuperview()
        }
    }
}
