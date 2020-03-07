//
//  ProductsController+CollectionViewDecorator.swift
//  BirdViewChallenge
//
//  Created by Insu Park on 2020/03/07.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

// MARK:- Collection View Data Source

extension ProductsController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        return configureReusableView(collectionView: collectionView, kind: kind, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return configureCell(collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        viewModel.fetchMoreProducts(skinType: self.skinType,
                                    indexPath: indexPath) { [weak self] in
                                        guard let self = self else { return }
                                        self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        openSelectedCell(indexPath: indexPath)
    }
    
}

// MARK:- Collection View Delegate

extension ProductsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 12, bottom: 20, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
}

extension ProductsController: CollectionViewDecorator {
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductsCell.self),
                                                            for: indexPath) as? ProductsCell else {
                                                                return UICollectionViewCell() }
        cell.viewModel = ProductsCellViewModel(content: viewModel.fetchedProducts[indexPath.row])
        return cell
    }
    
    func configureReusableView(collectionView: UICollectionView,
                               kind: String,
                               indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: String(describing: ProductsFooter.self),
                                                                               for: indexPath) as? ProductsFooter else {
                                                                                return UICollectionReusableView() }
            footer.imageView.layer.add(Tools.rotation.rotationAnimation, forKey: "rotationAnimation")
            return footer
        default:
            return UICollectionReusableView()
        }
        
    }
}
