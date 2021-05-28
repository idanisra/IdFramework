//
//  UITableView+Extension.swift
//  IdFramework
//
//  Created by Idan Israel - Personal on 28/05/2021.
//

import UIKit
import Foundation

/// MARK: - UITableView Extension
extension UITableView {
    /// MARK: - Public Functions
    public func setupTableView(parentVC: UIViewController, nibName: String, separatorStyle: UITableViewCell.SeparatorStyle  = .none ) {
        self.delegate = parentVC as? UITableViewDelegate
        self.dataSource = parentVC as? UITableViewDataSource
        
        let cellNib = UINib(nibName: nibName, bundle: nil)
        self.register(cellNib, forCellReuseIdentifier: nibName)
        
        self.tableFooterView = UIView()
        self.separatorStyle = separatorStyle
    }
}
