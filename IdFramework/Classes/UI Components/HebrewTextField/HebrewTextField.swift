//
//  HebrewTextField.swift
//  OnceUponAMeat
//
//  Created by Idan Israel on 03/08/2020.
//  Copyright © 2020 Idan Israel. All rights reserved.
//

import UIKit

/// MARK: - HebrewTextField

public class HebrewTextField: UITextField {
    /// MARK: - Variables
    
    public var originalRect = CGRect.zero

    /// MARK: - Public Overridden Functions
    
    public override func awakeFromNib() {
        super.awakeFromNib()

        originalRect = super.clearButtonRect(forBounds: bounds)
        clearButtonMode = .whileEditing
        textAlignment = .center
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()

        for view in subviews {
            if let button = view as? UIButton {
                button.setImage(button.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
                button.tintColor = .white
            }
        }
    }
    
    public override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        return originalRect.offsetBy(dx: -originalRect.origin.x + 5, dy: 0)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: originalRect.size.width, y: bounds.origin.y, width: bounds.size.width-originalRect.size.width, height: bounds.size.height)
        return bounds.insetBy(dx: 13, dy: 3)
    }
}
