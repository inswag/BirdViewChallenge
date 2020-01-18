//
//  ProductImageCell.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 18/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

class ProductImageCell: UITableViewCell {
    
    // MARK:- UI Properties
    
    let productImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        return iv
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorWithHexString(hexString: Tools.color.grayWhite)
        return view
    }()
    
    // MARK:- Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: String(describing: ProductController.self))
        self.setupUIComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUIComponents() {
        backgroundColor = .red
//        selectionStyle = .none
        layer.cornerRadius = 30
        clipsToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        [productImage, borderView].forEach { self.addSubview($0) }
        
        borderView.snp.makeConstraints { (m) in
            m.leading.trailing.bottom.equalToSuperview()
            m.height.equalTo(1)
        }
        
        productImage.snp.makeConstraints { (m) in
            m.top.leading.trailing.equalToSuperview()
            m.bottom.equalTo(borderView.snp.top)
            
        }
    }
    
}
