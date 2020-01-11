//
//  ProductsViewController.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 06/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import SnapKit

class ProductsViewController: ViewController {
    
    // MARK:- Properties
    
    let navigate: Navigator
    let viewModel: ProductsViewModel

    // MARK: - UI Properties
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.footerReferenceSize = CGSize(width: view.frame.width, height: 96)
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .red
        cv.setCollectionViewLayout(layout, animated: true)
        cv.dataSource = self
        cv.delegate = self
        cv.register(ProductsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: ProductsHeader.self))
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
    
    // MARK:- Initialize
    
    init(viewModel: ProductsViewModel, navigator: Navigator) {
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
    }
    
    override func setupUIComponents() {
        
        // UICollectionView
        
        [self.collectionView].forEach { self.view.addSubview($0) }
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        
        // UISearchBar
        
        navigationController?.navigationBar.addSubview(searchBar)
        
        
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
    
    
    
    
}

// MARK:- Search Bar Delegate

extension ProductsViewController: UISearchBarDelegate {
    
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

extension ProductsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: ProductsHeader.self), for: indexPath) as! ProductsHeader
            header.backgroundColor = .black
            return header
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
        cell.backgroundColor = .white
        return cell
    }
    
    // Handle Collection View Header & Footer
    //
    //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //        switch kind {
    //        case UICollectionView.elementKindSectionHeader:
    //            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: ProductsHeader.self), for: indexPath) as! ProductsHeader
    //
    //
    //            return header
    //        default:
    //            return UICollectionReusableView()
    //        }
    //    }
    
    
}

// MARK:- Collection View Delegate

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }
    
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
