//
//  CollectionViewDecorator.swift
//  BirdViewChallenge
//
//  Created by Insu Park on 2020/03/07.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

protocol CollectionViewDecorator {
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}
