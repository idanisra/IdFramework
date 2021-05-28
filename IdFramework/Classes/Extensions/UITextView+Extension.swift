//
//  UITextView+Extension.swift
//  IdFramework
//
//  Created by Idan Israel - Personal on 28/05/2021.
//

import UIKit
import Foundation

/// MARK: - UITextView Extension

extension UITextView {
    /// MARK: - Public Functions
    
    public func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        let toolbar: UIToolbar = UIToolbar()
        
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "סיום", style: .done, target: onDone.target, action: onDone.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    /// MARK: - Private Functions
    
    @objc private func doneButtonTapped() {
        self.resignFirstResponder()
    }
}
