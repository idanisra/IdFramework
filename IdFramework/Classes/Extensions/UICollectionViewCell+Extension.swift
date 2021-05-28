//
//  UICollectionViewCell+Extension.swift
//  IdFramework
//
//  Created by Idan Israel - Personal on 28/05/2021.
//

import UIKit
import Foundation

/// MARK: - UICollectionViewCell Extension
extension UICollectionViewCell {
    /// MARK: - Public Functions
    public static func getReusableIdentifier() -> String {
        return String(describing: self)
    }
}
