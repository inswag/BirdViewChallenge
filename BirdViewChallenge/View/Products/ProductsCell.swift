//
//  ProductsCell.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 08/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import Kingfisher

class ProductsCell: CollectionViewCell {
    
    // MARK:- Properties
    
    var viewModel: ProductsCellViewModel! {
      didSet {
        let imageURL = URL(string: viewModel.thumbnail)
        photoImageView.kf.setImage(with: imageURL)
        productNameTitle.text = viewModel.title
        
        // Price
        let price = Tools.numberFormatter(stringNumber: viewModel.price)
        let attributedTitle = NSMutableAttributedString(string: price,
                                                        attributes: [NSAttributedString.Key.font: Tools.font.notoSansCJKkrBold(size: 14),
                                                                     NSAttributedString.Key.foregroundColor: UIColor.colorWithHexString(hexString: Tools.color.darkGray)])
        attributedTitle.append(NSAttributedString(string: "원",
                                                  attributes: [NSAttributedString.Key.font: Tools.font.appleSDGothicNeoBold(size: 14.0),
                                                               NSAttributedString.Key.foregroundColor: UIColor.colorWithHexString(hexString: Tools.color.darkGray)]))
        priceNameTitle.attributedText = attributedTitle
      }
    }
    
    
    // MARK:- UI Properties
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        // .scaleAspectFill : 사진의 본래에 사이즈에 맞춘다.
        iv.contentMode = .scaleAspectFill
        // .clipsToBounds = true  : 사진을 셀 사이즈까지만 보여주게 자른다.
        iv.clipsToBounds = true
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = 14
        iv.layer.borderColor = Tools.color.lightGray
        iv.layer.borderWidth = 1
        return iv
    }()
    
    let productNameTitle: UILabel = {
        let label = UILabel()
        label.font = Tools.font.notoSansCJKkrBlack(size: 14)
        label.text = "ProductName\nProductName"
        label.numberOfLines = 2
        label.textColor = UIColor.colorWithHexString(hexString: Tools.color.lightBlack)
        return label
    }()
    
    let priceNameTitle: UILabel = {
        let label = UILabel()
//        label.font = Tools.font.notoSansCJKkrBold(size: 14)
//        label.text = "price"
        label.numberOfLines = 1
//        label.textColor = UIColor.colorWithHexString(hexString: Tools.color.darkGray)
        return label
    }()
    
    // MARK:- Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- UI Methods
    
    override func setupUIComponents() {
        [photoImageView, productNameTitle, priceNameTitle].forEach { self.contentView.addSubview($0) }
        
        photoImageView.snp.makeConstraints { (m) in
            m.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top)
            m.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading)
            m.trailing.equalTo(self.contentView.safeAreaLayoutGuide.snp.trailing)
            m.height.equalTo(172)
        }
        
        productNameTitle.snp.makeConstraints { (m) in
            m.top.equalTo(self.photoImageView.snp.bottom).offset(4)
            m.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading).offset(8)
            m.trailing.equalTo(self.contentView.safeAreaLayoutGuide.snp.trailing).offset(-8)
        }
        
        priceNameTitle.snp.makeConstraints { (m) in
            m.top.equalTo(self.productNameTitle.snp.bottom)
            m.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading).offset(8)
            m.trailing.equalTo(self.contentView.safeAreaLayoutGuide.snp.trailing).offset(-8)
        }
    }
    
    
}
