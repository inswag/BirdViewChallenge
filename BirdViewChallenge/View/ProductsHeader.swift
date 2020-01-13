//
//  ProductsHeader.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 11/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

class ProductsHeader: UICollectionReusableView {
    
    // MARK:- UI Properties
    
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
        btn.setImage(UIImage(named: "arrow_down_black"), for: .normal)
        return btn
    }()
    
    let bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(r: 33, g: 47, b: 62, a: 0.1)
        return view
    }()
    
    // MARK:- Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        backgroundColor = .white
        //        self.setupUIComponents()
        //        self.imageView.rotate()
        setupUIComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Methods
    
    func setupUIComponents() {
        //        backgroundColor = .blue
        
        [typeName, typeButton, bottomBorder].forEach { self.addSubview($0) }
        
        typeButton.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            m.trailing.equalToSuperview().offset(-12)
            m.width.equalTo(24)
            m.height.equalTo(24)
        }
        
        typeName.snp.makeConstraints { (m) in
            m.centerY.equalTo(typeButton.snp.centerY)
            m.trailing.equalTo(typeButton.snp.leading).offset(5)
        }
        
        bottomBorder.snp.makeConstraints { (m) in
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
            m.bottom.equalToSuperview()
            m.height.equalTo(1)
        }
        
    }
}
