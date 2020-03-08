//
//  ProductController.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 17/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import SnapKit

class ProductController: ViewController {
    
    // MARK:- Properties
    
    let navigate: Navigator
    let viewModel: ProductControllerViewModel
    
    // MARK:- UI Properties
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.dataSource = self
        tv.delegate = self
        tv.register(ProductImageCell.self, forCellReuseIdentifier: String(describing: ProductImageCell.self))
        tv.register(ProductTagCell.self, forCellReuseIdentifier: String(describing: ProductTagCell.self))
        tv.register(ProductDescriptionCell.self, forCellReuseIdentifier: String(describing: ProductDescriptionCell.self))
        return tv
    }()
    
    lazy var closeButton: UIButton = {
        let btn = UIButton()
        let btnImg = UIImage(named: "close_white")
        btn.setImage(btnImg, for: .normal)
        btn.backgroundColor = UIColor.rgb(r: 24, g: 24, b: 40, a: 0.16)
        btn.addTarget(self, action: #selector(actionClose), for: .touchUpInside)
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    @objc func actionClose() {
        self.dismiss(animated: true, completion: nil)
    }
    
    lazy var purchaseButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.colorWithHexString(hexString: "#9013FE")
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("구매하기", for: .normal)
        btn.titleLabel?.font = Tools.font.notoSansCJKkrBlack(size: 18.0)
        btn.layer.cornerRadius = 14
        return btn
    }()
    
    // MARK:- Initialize
    
    init(viewModel: ProductControllerViewModel, navigator: Navigator) {
        self.viewModel = viewModel
        self.navigate = navigator
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchProductSelected()
    }
    
    // MARK:- UI Method
    
    override func setupUIComponents() {
        
        // transparent background
        self.view.isOpaque = false
        self.view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        // UI Layouts
        [borderView, tableView, closeButton, purchaseButton].forEach {
            self.view.addSubview($0)
        }
        
    }
    
    override func setupUILayout() {
        
        borderView.snp.makeConstraints { (m) in
            m.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            m.width.equalTo(80)
            m.height.equalTo(6)
            m.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { (m) in
            m.top.equalTo(borderView.snp.bottom).offset(8)
            m.leading.trailing.bottom.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { (m) in
            m.top.equalTo(tableView.snp.top).offset(16)
            m.trailing.equalTo(tableView.snp.trailing).offset(-16)
            m.width.equalTo(40)
            m.height.equalTo(40)
        }
        
        purchaseButton.snp.makeConstraints { (m) in
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
            m.bottom.equalToSuperview().offset(30)
            m.height.equalTo(52)
        }
        
    }
    
    func setupUIAnimation() {
        DispatchQueue.main.async {
            self.purchaseButton.snp.updateConstraints { $0.bottom.equalToSuperview().offset(-30) }
            UIView.animate(withDuration: 1.0,
                           delay: 0.0,
                           options: [.curveEaseInOut],
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    // MARK:- Network Method
    
    func fetchProductSelected() {
        viewModel.fetchProductSelected(id: viewModel.id) { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.setupUIAnimation()
        }
    }
    
}
