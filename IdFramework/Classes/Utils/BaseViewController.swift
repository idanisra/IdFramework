//
//  BaseViewController.swift
//  OnceUponAMeat
//
//  Created by Idan Israel on 29/07/2020.
//  Copyright © 2020 Idan Israel. All rights reserved.
//

import UIKit

/// MARK: - BaseViewController
public class BaseViewController: UIViewController, UITextFieldDelegate {
    /// MARK: - Public Overridden Functions
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /// MARK: - Public Functions
    public func textFieldDidBeginEditing (_ textField: UITextField) {
        if #available(iOS 13.0, *) {
            Utils.textFieldDidBeginEditing(view: self.view, textField: textField)
        }
    }
    
    public func textFieldDidEndEditing (_ textField: UITextField) {
        Utils.textFieldDidEndEditing(view: self.view, textField: textField)
    }
    
    public func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        return Utils.textFieldShouldReturn(textField: textField)
    }
}
