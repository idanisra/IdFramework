//
//  String+Extension.swift
//  IdFramework
//
//  Created by Idan Israel - Personal on 28/05/2021.
//

import Foundation

/// MARK: - String Extension

extension String {
    /// MARK: - Variables
    
    public var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    public var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
