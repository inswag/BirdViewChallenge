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
    
    // MARK:- UI Properties
    
    let productDescriptionTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansCJKkr-Bold", size: 16.0)
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed pretium quam vel libero lobortis tempus. Curabitur sagittis, justo congue pellentesque iaculis, elit nibh dapibus tortor, vulputate bibendum enim dolor vel quam. Mauris accumsan, magna vel tincidunt tristique, justo felis porttitor nulla, id congue eros nisi at augue. Aliquam sollicitudin risus ut varius consectetur. Donec non quam luctus, consequat tortor ornare, rutrum velit. Sed molestie porta ornare. Nam tempor nisi a mi blandit, eu luctus nulla ultrices. Aliquam in turpis odio. Etiam in eros dolor. Aenean sit amet risus nec sapien finibus ornare a porta dolor. Praesent rhoncus nulla in mattis vehicula. \n\n Nunc accumsan nisl ac metus blandit tincidunt. Interdum et malesuada fames ac ante ipsum primis in faucibus. Mauris ultricies consequat pulvinar. Sed condimentum mi nec justo aliquet, eget rhoncus dolor volutpat. Curabitur tincidunt cursus dolor. Ut metus risus, porttitor eget accumsan in, porta ac mauris. Curabitur fermentum diam ac mollis placerat. Quisque diam ante, congue sed semper interdum, volutpat ac mauris. Morbi tristique porta mauris eget iaculis. \n\n Donec nec mi fermentum, condimentum magna ut, luctus elit. Nam eu dolor ut augue condimentum lacinia ac at lacus. Aliquam consequat ligula felis. Praesent vel sollicitudin velit. Nulla ac purus malesuada, finibus augue vitae, aliquam neque. Cras eu blandit ex, vitae dapibus tellus. Aliquam posuere arcu a enim malesuada lobortis. Sed eros lacus, maximus et magna sit amet, consequat feugiat dolor. Nullam massa nibh, sollicitudin nec eros non, aliquet dictum neque. Aenean accumsan posuere nisl vitae congue."
        label.numberOfLines = 0
        label.textColor = UIColor.rgb(r: 20, g: 20, b: 40)
        return label
    }()
    
    let legalDescriptionView: UIView = {
        let view = UIView()
        let label = UILabel()
        view.addSubview(label)
        view.backgroundColor = UIColor.colorWithHexString(hexString: Tools.color.whiteAndBlack)
        view.layer.cornerRadius = 14
        label.text = "부랑구마켓은 통신판매중개자이며 통신판매의 당사자가 아닙니다. 따라서 부랑구마켓은 상품 거래정보 및 거래에 대하여 책임을 지지 않습니다."
        label.textAlignment = .center
        label.font = Tools.font.notoSansCJKkrBold(size: 12.0)
        label.textColor = UIColor.colorWithHexString(hexString: Tools.color.lightWhite)
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
    
    // MARK:- Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: String(describing: ProductController.self))
        
        self.setupUIComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK:- Method
    
    func setupUIComponents() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        [productDescriptionTitle, legalDescriptionView].forEach {
            self.contentView.addSubview($0)
        }
        
        productDescriptionTitle.snp.makeConstraints { (m) in
            m.top.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
        }
        
        legalDescriptionView.snp.makeConstraints { (m) in
            m.top.equalTo(self.productDescriptionTitle.snp.bottom).offset(68)
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
            m.bottom.equalToSuperview().offset(-122)
        }
    }
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
