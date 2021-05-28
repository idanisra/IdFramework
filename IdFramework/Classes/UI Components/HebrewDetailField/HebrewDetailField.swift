//
//  HebrewDetailField.swift
//  OnceUponAMeat
//
//  Created by Idan Israel on 03/08/2020.
//  Copyright © 2020 Idan Israel. All rights reserved.
//

import UIKit

/// MARK: - Protocols

protocol HebrewDetailFieldProtocol {
    /// MARK: - Functions
    
    func updateText(text: String)
    func returnPressed()
}

/// MARK: - HebrewDetailField

public class HebrewDetailField: UIView {
    @IBOutlet var contentView: HebrewDetailField!
    @IBOutlet weak var detailValueTextBox: HebrewTextField!
    @IBOutlet weak var topPlaceHolder: UILabel!
    @IBOutlet weak var defaultPlaceHolder: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    /// MARK: - Variables
    var delegate: HebrewDetailFieldProtocol?
    var showRegularPlaceHolder = true {
        didSet {
            UIView.animate(withDuration: 0.8) {
                self.defaultPlaceHolder.isHidden = !self.showRegularPlaceHolder
                self.topPlaceHolder.isHidden = self.showRegularPlaceHolder
            }
        }
    }
    var parentVC: UIViewController?
    
    /// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    func commonInit(){
        Bundle.main.loadNibNamed("HebrewDetailField", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [ .flexibleHeight, .flexibleWidth ]
        
        self.showRegularPlaceHolder = true
        self.detailValueTextBox.delegate = self
        self.detailValueTextBox.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    /// MARK: - Functions
    public func setupDetailView(placeHolder: String, iconImage: String) {
        self.topPlaceHolder.text = placeHolder
        self.defaultPlaceHolder.text = placeHolder
        self.icon.image = UIImage(named: iconImage)
        
        self.icon.image = self.icon.image?.withRenderingMode(.alwaysTemplate)
        self.icon.tintColor = UIColor.white
    }
    
    public override func resignFirstResponder() -> Bool {
        let resignFirstResponder = super.resignFirstResponder()
        self.detailValueTextBox.resignFirstResponder()
        
        return resignFirstResponder
    }
}

/// MARK: - HebrewDetailField Extension

extension HebrewDetailField: UITextFieldDelegate {
    /// MARK: Public Functions
    
    @objc public func textFieldDidChange(_ textField: UITextField) {
        self.delegate?.updateText(text: self.detailValueTextBox.text ?? "")
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.delegate?.returnPressed()
        self.delegate?.updateText(text: self.detailValueTextBox.text ?? "")
        
        _ = Utils.textFieldShouldReturn(textField: textField)
        textField.endEditing(true)
        
        return false
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.showRegularPlaceHolder = false
        if let view = self.parentVC?.view {
            if #available(iOS 13.0, *) {
                Utils.textFieldDidBeginEditing(view: view, textField: textField)
            }
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.showRegularPlaceHolder = self.detailValueTextBox.text?.count == 0
        if let view = self.parentVC?.view {
            Utils.textFieldDidEndEditing(view: view, textField: textField)
        }
    }
}
