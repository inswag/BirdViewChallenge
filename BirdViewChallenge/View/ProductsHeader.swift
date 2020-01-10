//
//  ProductsHeader.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 09/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

class ProductsHeader: UICollectionReusableView {
    
    let typeName: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "모든 피부 타입"
        label.textColor = UIColor.colorWithHexString(hexString: Tools.color.black)
        label.font = Tools.font.appleSDGothicNeoBold(size: 14)
        return label
    }()
    
    let typeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("타입", for: .normal)
        btn.titleLabel?.font = Tools.font.appleSDGothicNeoBold(size: 14)
        btn.titleLabel?.textColor = UIColor.colorWithHexString(hexString: Tools.color.black)
        // Todo: - Text -> Image
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .white
//        self.setupUIComponents()
//        self.imageView.rotate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUIComponents() {
        backgroundColor = .blue
        
        [typeName, typeButton].forEach { addSubview($0) }
        
        typeButton.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            m.trailing.equalToSuperview().offset(-12)
            m.width.equalTo(24)
            m.height.equalTo(24)
        }
        
        typeName.snp.makeConstraints { (m) in
            m.centerY.equalTo(typeButton.snp.centerY)
            m.trailing.equalTo(typeButton.snp.leading)
        }
        
        
    }
}
