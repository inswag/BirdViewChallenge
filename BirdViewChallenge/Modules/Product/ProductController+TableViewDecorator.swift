//
//  ProductController+TableViewDecorator.swift
//  BirdViewChallenge
//
//  Created by Insu Park on 2020/03/08.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

// MARK:- Table View Data Source

extension ProductController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCell(tableView: tableView, indexPath: indexPath)
    }
    
}

// MARK:- Table View Delegate

extension ProductController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch ProductControllerViewModel.CellType(rawValue: indexPath.row) {
        case .image:
            let height: CGFloat = self.view.frame.width
            return height
        case .tag, .description:
            return UITableView.automaticDimension
        default:
            return 200
        }
    }
}

// MARK:- Table View Decorator

extension ProductController: TableViewDecorator {
    
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let rowData = viewModel.fetchedProduct else { return UITableViewCell() }
        
        switch ProductControllerViewModel.CellType(rawValue: indexPath.row){
        case .image:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductImageCell.self),
                                                           for: indexPath) as? ProductImageCell else {
                                                            return UITableViewCell() }
            cell.viewModel = ProductImageCellViewModel(content: rowData)
            return cell
        case .tag:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductTagCell.self),
                                                           for: indexPath) as? ProductTagCell else {
                                                            return UITableViewCell() }
            
            cell.viewModel = ProductTagCellViewModel(content: rowData)
            return cell
        case .description:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductDescriptionCell.self),
                                                           for: indexPath) as? ProductDescriptionCell else {
                                                            return UITableViewCell() }
            cell.viewModel = ProductDescriptionCellViewModel(content: rowData)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}
