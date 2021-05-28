//
//  UIView+Extension.swift
//  IdFramework
//
//  Created by Idan Israel - Personal on 28/05/2021.
//

import UIKit
import Foundation

/// MARK: - UIView Extension
extension UIView {
    /// MARK: - Public Functions
    public func removeKeyboard() {
        for subview in self.subviews {
            subview.resignFirstResponder()
        }
    }
}
