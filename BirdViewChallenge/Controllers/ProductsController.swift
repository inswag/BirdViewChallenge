//
//  ProductsController.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 06/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import SnapKit

class ProductsController: ViewController {
    
    // MARK:- Properties
    
    let navigate: Navigator
    let viewModel: ProductsControllerViewModel

    // Network Property
    let productsService: ProductsServiceType = ProductsService()
//    var page: Int = 2
    
    // PickerView Property
    let temporaryArray = ["모든 피부 타입", "지성", "건성", "민감성"]
    
    // MARK: - UI Properties
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.footerReferenceSize = CGSize(width: view.frame.width, height: 96)
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.setCollectionViewLayout(layout, animated: true)
        cv.dataSource = self
        cv.delegate = self
//        cv.register(ProductsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: ProductsHeader.self))
        cv.register(ProductsFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: ProductsFooter.self))
        cv.register(ProductsCell.self, forCellWithReuseIdentifier: String(describing: ProductsCell.self))
        
        return cv
    }()
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "검색"
        sb.barTintColor = UIColor.white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = Tools.font.appleSDGothicNeoRegular(size: 17)
        sb.delegate = self
        return sb
    }()
    
    let headerView: UIView = {
        let view = UIView()
        let bottomBorder = UIView()
        view.backgroundColor = .white
        view.addSubview(bottomBorder)
        bottomBorder.backgroundColor = UIColor.rgb(r: 33, g: 47, b: 62, a: 0.1)
        bottomBorder.snp.makeConstraints { (m) in
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
            m.bottom.equalToSuperview()
            m.height.equalTo(1)
        }
        return view
    }()
    
    let typeName: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "모든 피부 타입"
        label.textColor = UIColor.colorWithHexString(hexString: Tools.color.black)
        label.font = Tools.font.appleSDGothicNeoBold(size: 14)
        return label
    }()

    lazy var typeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "arrow_down_black"), for: .normal)
        btn.addTarget(self, action: #selector(actionClickButton), for: .touchUpInside)
        return btn
    }()

    @objc func actionClickButton() {
//        delegate?.actionButton()
        print("???")
    }
    
    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = .black
//        pv.delegate = self
        pv.isHidden = false
        return pv
    }()
    
    
    // MARK:- Initialize
    
    init(viewModel: ProductsControllerViewModel, navigator: Navigator) {
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

        // Do any additional setup after loading the view.
        self.fetchProductsAllType()
    }
    
    override func setupUIComponents() {
        
        // Components in VC
        
        [headerView, collectionView].forEach { self.view.addSubview($0) }
        
        let height = Int((UIApplication.shared.statusBarFrame.height) ?? 0 ) + Int((self.navigationController?.navigationBar.frame.height) ?? 0.0)
        headerView.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(height)
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
            m.height.equalTo(50)
        }
        collectionView.snp.makeConstraints { (m) in
            m.top.equalTo(headerView.snp.bottom)
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
            m.bottom.equalToSuperview()
        }
        
        // Components in Header View
        
        [typeName, typeButton].forEach { self.headerView.addSubview($0) }

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
        
        
        // UISearchBar
        
        navigationController?.navigationBar.addSubview(searchBar)
        
        // UIPickerView
        
//        [pickerView].forEach { self.view.addSubview($0) }
//        pickerView.snp.makeConstraints { (m) in
//            m.leading.equalToSuperview()
//            m.trailing.equalToSuperview()
//            m.bottom.equalToSuperview()
//            m.height.equalTo(240)
//        }
        
        // - Access To UISearchBar Glass Icon
        
        let textField = self.searchBar.value(forKey: "searchField") as! UITextField
        let glassIconView = textField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        glassIconView.tintColor = UIColor.colorWithHexString(hexString: Tools.color.gray, alpha: 0.4)
        
        // - Accesss To UISearchBar Placeholder
        
        textField.textColor = UIColor.colorWithHexString(hexString: Tools.color.gray, alpha: 0.4)
        
        let textFieldInsideSearchBarLabel = textField.value(forKey: "placeholderLabel") as! UILabel
        textFieldInsideSearchBarLabel.textColor = UIColor.colorWithHexString(hexString: Tools.color.gray, alpha: 0.4)
        self.searchBar.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.leading.equalToSuperview().offset(12)
            m.trailing.equalToSuperview().offset(-12)
            m.bottom.equalToSuperview().offset(-12)
        }
        
    }
    
    // MARK:- Network Method
    
    fileprivate func fetchProductsAllType() {
        viewModel.fetchAllTypeProducts { self.collectionView.reloadData() }
    }
    
    fileprivate func paginateProducts() {
//        print("will Paginate User List!")
//        print("pageNumber: ", page)
//        fetchProducts(since: page)
//        page += 1
    }
    
    
}

// MARK:- Search Bar Delegate

extension ProductsController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //        if searchText.isEmpty {
        //            filteredUsers = users
        //        } else {
        //            filteredUsers = self.users.filter { (user) -> Bool in
        //                return user.username.lowercased().contains(searchText.lowercased())
        //            }
        //        }
        //
        //        self.collectionView?.reloadData()
        
    }
}

// MARK:- Collection View Data Source

extension ProductsController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
//        case UICollectionView.elementKindSectionHeader:
//            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: ProductsHeader.self), for: indexPath) as! ProductsHeader
//            header.backgroundColor = .white
//            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: ProductsFooter.self), for: indexPath) as! ProductsFooter
            footer.backgroundColor = .blue
            return footer
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductsCell.self), for: indexPath) as! ProductsCell
        cell.viewModel = ProductsCellViewModel(content: viewModel.fetchedProducts[indexPath.row])
        return cell
    }
    
}

// MARK:- Collection View Delegate

extension ProductsController: UICollectionViewDelegateFlowLayout {
    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: self.view.frame.width, height: 50)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Width
        let width: CGFloat = self.view.frame.width
        let leftEdge: CGFloat = 12
        let rightEdge: CGFloat = 12
        let interspace: CGFloat = 7
        let totalWidth: CGFloat = (width - leftEdge - rightEdge - interspace) / 2
        // Height = 236
        let imageHeight: CGFloat = 172
        let padding: CGFloat = 4
        let titleHeight: CGFloat = 40
        let priceHeight: CGFloat = 20
        let totalHeight: CGFloat = (imageHeight + padding + titleHeight + priceHeight)
        return CGSize(width: totalWidth, height: totalHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 12, bottom: 20, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //
    //        switch kind {
    //        case UICollectionView.elementKindSectionHeader:
    //            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: ProductsHeader.self), for: indexPath) as! ProductsHeader
    //
    //            return header
    //        default:
    //            return UICollectionReusableView()
    //        }
    //
    //    }
    
    
    
}

//extension ProductsController: ProductsHeaderDelegate {
//
//    func actionButton() {
//        self.pickerView.isHidden = true
//        print("sss")
//    }
//
//}

// MARK:- UIPickerView
//
//extension ProductsController: UIPickerViewDelegate, UIPickerViewDataSource {
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return self.temporaryArray.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return self.temporaryArray[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//    }
//
//
//}