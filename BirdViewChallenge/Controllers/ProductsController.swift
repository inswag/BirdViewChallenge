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

class ProductsController: ViewController {
    
    // MARK:- Properties
    
    let navigate: Navigator
    let viewModel: ProductsControllerViewModel
    var skinType: String = "oily"
    
//    let provide = NetworkManager
    let provider = MoyaProvider<BirdViewService>()
    
    // MARK: - View State
    private var state: State = .loading {
      didSet {
        switch state {
        case .ready:
            print("ready")
//          viewMessage.isHidden = true
//          tblComics.isHidden = false
//          tblComics.reloadData()
        case .loading:
             print("loading")
//          tblComics.isHidden = true
//          viewMessage.isHidden = false
//          lblMessage.text = "Getting comics ..."
//          imgMeessage.image = #imageLiteral(resourceName: "Loading")
        case .error:
             print("error")
//          tblComics.isHidden = true
//          viewMessage.isHidden = false
//          lblMessage.text = """
//                              Something went wrong!
//                              Try again later.
//                            """
//          imgMeessage.image = #imageLiteral(resourceName: "Error")
        }
      }
    }
    
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
        
        
        
        state = .loading
        
        provider.request(.allType) { [weak self] result in
            print("result: \(result)")
            guard let self = self else { return }
//
            switch result {
            case .success(let response):
                do {
                    print("response: \(response)")
                    print("response.data: \(response.data)")
                    print("response.mapJSON: \(try response.mapJSON())")
                    
                    
////                    self.state = .ready(response)
//                    let data = response.data
//                    print(data)
//                    let statusCode = response.statusCode
//                    print(statusCode)
//                    // GitTEST
//
                } catch {
                    print("here")
                    self.state = .error
                }
            case .failure:
                print("there")
                self.state = .error
            }
        }
        
        
        // Do any additional setup after loading the view.
//        self.fetchProductsAllType()
    }
    
    override func setupUIComponents() {
        
        // Components in VC
        
        self.view.backgroundColor = .white
        [headerView, collectionView].forEach { self.view.addSubview($0) }
        
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        let height = (self.navigationController?.navigationBar.frame.height ?? 0.0)
        
        headerView.snp.makeConstraints { (m) in
            if #available(iOS 13.0, *) {
                m.top.equalToSuperview().offset(height + (window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 90.0))
            } else {
                m.top.equalToSuperview().offset(height + UIApplication.shared.statusBarFrame.height)
            }
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
            m.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { (m) in
            m.top.equalTo(headerView.snp.bottom)
            m.leading.trailing.bottom.equalToSuperview()
        }
        
        // Components in Header View
        
        [typeName, pickerContainer].forEach { self.headerView.addSubview($0) }

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
        
        [typeButton].forEach { self.pickerContainer.addSubview($0) }
        typeButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        
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
            m.leading.bottom.equalToSuperview().offset(12)
            m.trailing.equalToSuperview().offset(-12)
            m.bottom.equalToSuperview().offset(-8)
        }
        
    }
    
    // MARK:- Network Method
    
    fileprivate func fetchProductsAllType() {
//        viewModel.fetchAllTypeProducts { [weak self] in
//            self?.collectionView.reloadData()
//        }
    }
    
    // MARK:- Hide/Show Header Method
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    
}

extension ProductsController {
  enum State {
    case loading
    case ready([ProductsRoot])
    case error
  }
}

// MARK:- Search Bar Delegate

extension ProductsController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//                if searchText.isEmpty {
//                    filteredUsers = users
//                } else {
//                    filteredUsers = self.users.filter { (user) -> Bool in
//                        return user.username.lowercased().contains(searchText.lowercased())
//                    }
//                }
//
//                self.collectionView?.reloadData()
//
    }
    
//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//
//
//
////
//    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchedProducts.removeAll()
        print("This is \(self.skinType)")
        guard let text = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else { return }
        print("Here is \(text)")
//        viewModel.fetchProducts(by: text, and: skinType) {
//            self.collectionView.reloadData()
//        }
        
        self.searchBar.resignFirstResponder()
    }
}

// MARK:- Collection View Data Source

extension ProductsController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        viewModel.fetchMoreProducts(skinType: self.skinType, indexPath: indexPath) {
//            self.collectionView.reloadData()
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = viewModel.fetchedProducts[indexPath.item].id
        let productVC = navigate.get(segue: .product(id: id))
        self.present(productVC, animated: true)
    }
    
}

// MARK:- Collection View Delegate

extension ProductsController: UICollectionViewDelegateFlowLayout {
    
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
    
}

// MARK:- UIPickerView

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
//
//        viewModel.fetchedProducts.removeAll()
//        viewModel.page = 1
//
//        switch ProductsControllerViewModel.Types(rawValue: row) {
//        case .`default`:
//            viewModel.fetchAllTypeProducts {
//                self.skinType = ""
//                self.collectionView.reloadData()
//                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//            }
//        case .oily:
//            self.skinType = "oily"
//            viewModel.fetchProducts(by: "oily") {
//                self.collectionView.reloadData()
//                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//            }
//        case .dry:
//            self.skinType = "dry"
//            viewModel.fetchProducts(by: "dry") {
//
//                self.collectionView.reloadData()
//                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//
//            }
//        case .sensitive:
//            self.skinType = "sensitive"
//            viewModel.fetchProducts(by: "sensitive") {
//                self.collectionView.reloadData()
//                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//            }
//        default   :
//            print("해당 없음")
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.typeName.text = self.viewModel.typeArray[row]
//            self.pickerContainer.resignFirstResponder()
//        }
//
    }


}
