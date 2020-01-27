//
//  ProductPriceCell.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 18/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import SnapKit

class ProductTagCell: UITableViewCell {
    
    // MARK:- Properties
    
    var viewModel: ProductCellViewModel! {
      didSet {
        // Product
        productNameTitle.text = viewModel.title
        
        // Price
        let price = Tools.numberFormatter(stringNumber: viewModel.price)
        let attributedTitle = NSMutableAttributedString(string: price,
                                                        attributes: [NSAttributedString.Key.font: Tools.font.sFProTextBlack(size: 20.0),
                                                                     NSAttributedString.Key.foregroundColor: UIColor.colorWithHexString(hexString: Tools.color.violet)])
        attributedTitle.append(NSAttributedString(string: "원",
                                                  attributes: [NSAttributedString.Key.font: Tools.font.appleSDGothicNeoBold(size: 20.0),
                                                               NSAttributedString.Key.foregroundColor: UIColor.colorWithHexString(hexString: Tools.color.violet)]))
        priceNameTitle.attributedText = attributedTitle
      }
    }
    
    // MARK:- UI Properties
    
    let productNameTitle: UILabel = {
        let label = UILabel()
        label.font = Tools.font.appleSDGothicNeoBold(size: 32.0)
        label.text = "ProductName\nProductName\nProductName"
        label.numberOfLines = 0
        label.textColor = UIColor.colorWithHexString(hexString: Tools.color.lightBlack)
        return label
    }()
    
    let priceNameTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
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
    
    // MARK:- Methods
    
    func setupUIComponents() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        [productNameTitle, priceNameTitle, borderView].forEach { self.contentView.addSubview($0) }
        
        productNameTitle.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(34)
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
        }
        
        priceNameTitle.snp.makeConstraints { (m) in
            m.top.equalTo(self.productNameTitle.snp.bottom).offset(28)
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
            // Intrinsic Content Size
        }
        
        borderView.snp.makeConstraints { (m) in
            m.top.equalTo(self.priceNameTitle.snp.bottom).offset(32)
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
            m.bottom.equalToSuperview()
            m.height.equalTo(2)
        }
    }
    
    
}
