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
    
    
    // MARK:- Initialize
    
    init(navigator: Navigator) { // viewModel: ProductsControllerViewModel, navigator: Navigator, provider: NetworkManager
        //        self.viewModel = viewModel
        //        self.provider = provider
        self.navigate = navigator
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:- UI Method
    
    override func setupUIComponents() {
        
        // transparent background
        self.view.isOpaque = false
        self.view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        // UI Layouts
        [borderView, tableView].forEach { self.view.addSubview($0) }
        
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
        
    }
    
    
    
}

extension ProductController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductImageCell.self), for: indexPath) as! ProductImageCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductTagCell.self), for: indexPath) as! ProductTagCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductDescriptionCell.self), for: indexPath) as! ProductDescriptionCell
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    
}

extension ProductController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            let height: CGFloat = self.view.frame.width
            return height
        case 1, 2:
            return UITableView.automaticDimension
        default:
            return 200
        }
    }
}
