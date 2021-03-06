//
//  ProductsController.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 06/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import SnapKit
import Moya
import NVActivityIndicatorView

class ProductsController: ViewController {
    
    // MARK:- Properties
    
    let navigate: Navigator
    let viewModel: ProductsControllerViewModel
    var skinType: String = "oily"
    var activityIndicatorView: NVActivityIndicatorView!
    
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
        cv.register(ProductsFooter.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: String(describing: ProductsFooter.self))
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
            m.leading.trailing.bottom.equalToSuperview()
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
        self.pickerContainer.becomeFirstResponder()
    }
    
    lazy var pickerContainer: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.tintColor = .clear
        tf.inputView = self.pickerView
        return tf
    }()
    
    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = UIColor.colorWithHexString(hexString: "#9013FE")
        pv.tintColor = .white
        pv.delegate = self
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
    
    // MARK:- UI Method
    
    override func setupUIComponents() {
        let x: CGFloat = self.view.center.x - 50
        let y: CGFloat = self.view.center.y - 50

        // NVActivity Indicator
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: x, y: y, width: 100, height: 100),
                                                        type: .lineSpinFadeLoader,
                                                        color: .lightGray,
                                                        padding: 30)
        // Components in VC
        
        self.view.backgroundColor = .white
        [headerView, collectionView].forEach { self.view.addSubview($0) }
        [activityIndicatorView].forEach { self.view.addSubview($0) }
        

        // Components in Header View
        
        [typeName, pickerContainer].forEach { self.headerView.addSubview($0) }
        [typeButton].forEach { self.pickerContainer.addSubview($0) }
        
        // UISearchBar
        
        navigationController?.navigationBar.addSubview(searchBar)
        
        // - Access To UISearchBar Glass Icon
        
        let textField = self.searchBar.value(forKey: "searchField") as! UITextField
        let glassIconView = textField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        glassIconView.tintColor = UIColor.colorWithHexString(hexString: Tools.color.lightBlack, alpha: 0.4)
        
        // - Accesss To UISearchBar Placeholder
        
        textField.textColor = UIColor.colorWithHexString(hexString: Tools.color.lightBlack, alpha: 0.4)
        
        let textFieldInsideSearchBarLabel = textField.value(forKey: "placeholderLabel") as! UILabel
        textFieldInsideSearchBarLabel.textColor = UIColor.colorWithHexString(hexString: Tools.color.lightBlack, alpha: 0.4)
        self.searchBar.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.leading.equalToSuperview().offset(12)
            m.trailing.equalToSuperview().offset(-12)
            m.bottom.equalToSuperview().offset(-8)
        }
        
    }
    
    override func setupUILayout() {
        //        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        //        let height = (self.navigationController?.navigationBar.frame.height ?? 0.0)
        
        headerView.snp.makeConstraints { (m) in
            //            if #available(iOS 13.0, *) {
            //                m.top.equalToSuperview().offset(height + (window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 90.0))
            //            } else {
            //                m.top.equalToSuperview().offset(height + UIApplication.shared.statusBarFrame.height)
            //            }
            m.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
            m.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { (m) in
            m.top.equalTo(headerView.snp.bottom)
            m.leading.trailing.bottom.equalToSuperview()
        }
        
        // Components in Header View

        pickerContainer.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            m.trailing.equalToSuperview().offset(-12)
            m.width.equalTo(24)
            m.height.equalTo(24)
        }
        
        typeName.snp.makeConstraints { (m) in
            m.centerY.equalTo(pickerContainer.snp.centerY)
            m.trailing.equalTo(pickerContainer.snp.leading).offset(5)
        }
        
        typeButton.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    // MARK:- Network Method
    
    fileprivate func fetchProductsAllType() {
        viewModel.fetchAllTypeProducts { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
    
    public func openSelectedCell(indexPath: IndexPath) {
        let id = viewModel.fetchedProducts[indexPath.item].id
        let productVC = navigate.get(segue: .product(id: id))
        self.present(productVC, animated: true)
    }
    
    // MARK:- Touch Event
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.searchBar.resignFirstResponder()
    }
    
}

// MARK:- Scroll View Delegate

extension ProductsController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            let contentY = scrollView.contentOffset.y
                if contentY > 50 {
                    self.headerView.snp.updateConstraints { $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(50 - contentY) }
                    UIView.animate(withDuration: 0.1) { self.view.layoutIfNeeded() }
                } else {
                    self.headerView.snp.updateConstraints { $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin) }
                    UIView.animate(withDuration: 0.1) { self.view.layoutIfNeeded() }
                }
            }
        }

}

// MARK:- Search Bar Delegate

extension ProductsController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchedProducts.removeAll()
        guard let text = searchBar.text else { return }
        viewModel.fetchProducts(by: text, and: skinType) { [weak self] in
            self?.collectionView.reloadData()
        }
        
        self.searchBar.resignFirstResponder()
    }
}




// MARK:- UIPickerView Methods

extension ProductsController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.typeArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.typeArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activityIndicatorView.startAnimating()
        viewModel.fetchedProducts.removeAll()
        viewModel.page = 1

        switch ProductsControllerViewModel.Types(rawValue: row) {
        case .`default`, .oily:
            self.skinType = "oily"
        case .dry:
            self.skinType = "dry"
        case .sensitive:
            self.skinType = "sensitive"
        default:
            self.skinType = ""
        }
        
        viewModel.fetchProducts(by: self.skinType) { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            self.activityIndicatorView.stopAnimating()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            self.typeName.text = self.viewModel.typeArray[row]
            self.pickerContainer.resignFirstResponder()
        }
    }


}
