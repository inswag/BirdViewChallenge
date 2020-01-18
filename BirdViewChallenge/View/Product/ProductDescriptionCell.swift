//
//  ProductDescriptionCell.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 18/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import SnapKit

class ProductDescriptionCell: UITableViewCell {
    
    let legalDescriptionView: UIView = {
        let view = UIView() // 110/27
        let label = UILabel()
        view.addSubview(label)
        view.backgroundColor = UIColor.rgb(r: 246, g: 246, b: 250)
        view.layer.cornerRadius = 15
        label.text = "부랑구마켓은 통신판매중개자이며 통신판매의 당사자가 아닙니다. 따라서 부랑구마켓은 상품 거래정보 및 거래에 대하여 책임을 지지 않습니다."
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansCJKkr-Bold", size: 12.0)
        label.textColor = UIColor.rgb(r: 163, g: 163, b: 181)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.snp.makeConstraints { (m) in
            m.top.equalTo(view.snp.top).offset(16)
            m.leading.equalTo(view.snp.leading).offset(18)
            m.trailing.equalTo(view.snp.trailing).offset(-18)
            m.bottom.equalTo(view.snp.bottom).offset(-26)
        }
        return view
    }()
    
    let productDescriptionTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansCJKkr-Bold", size: 16.0)
        label.text = "Product Description"
        label.numberOfLines = 0
        label.textColor = UIColor.rgb(r: 20, g: 20, b: 40)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: String(describing: ProductController.self))
        
        self.setupUIComponents()
    }
    
    func configure(description: String) {
        self.productDescriptionTitle.text = description
    }
    
    func setupUIComponents() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        [productDescriptionTitle, legalDescriptionView].forEach {
            self.contentView.addSubview($0)
        }
        
        productDescriptionTitle.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(24)
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
        }
        
        legalDescriptionView.snp.makeConstraints { (m) in
            m.top.equalTo(self.productDescriptionTitle.snp.bottom).offset(40)
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
            m.bottom.equalToSuperview().offset(-122)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
