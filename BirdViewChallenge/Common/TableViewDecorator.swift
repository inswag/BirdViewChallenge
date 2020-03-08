//
//  TableViewDecorator.swift
//  BirdViewChallenge
//
//  Created by Insu Park on 2020/03/08.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

protocol TableViewDecorator {
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}
