//
//  UICollectionView+Extension.swift
//  IdFramework
//
//  Created by Idan Israel - Personal on 28/05/2021.
//

import UIKit
import Foundation

/// MARK: - UICollectionView Extension
extension UICollectionView {
    /// MARK: - Public Functions
    public func setupCollectionView(parentVC: Any, nibName: String, isRighToLeft: Bool = true) {
        self.delegate = parentVC as? UICollectionViewDelegate
        self.dataSource = parentVC as? UICollectionViewDataSource
        
        let cellNib = UINib(nibName: nibName, bundle: nil)
        self.register(cellNib, forCellWithReuseIdentifier: nibName)
        
        self.semanticContentAttribute = isRighToLeft ? .forceRightToLeft : .forceLeftToRight
    }
}
