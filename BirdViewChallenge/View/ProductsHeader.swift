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
        btn.addTarget(self, action: #selector(actionChooseType), for: .touchUpInside)
        return btn
    }()
    
    @objc func actionChooseType() {
//        self.pickerView.isHidden = false
    }
    
    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = .white
        pv.delegate = self
//        pv.isHidden = true
        return pv
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
        
        [typeName, typeButton, bottomBorder, pickerView].forEach { self.addSubview($0) }
        
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
    
    let temporaryArray = ["모든 피부 타입", "지성", "건성", "민감성"]
}

// MARK:- UIPickerView

extension ProductsHeader: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.temporaryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.temporaryArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 타입을 선택했을 때 처리해줄 메서드 정의
    }
    
    
}
