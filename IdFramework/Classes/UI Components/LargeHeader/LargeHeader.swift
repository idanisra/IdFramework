//
//  LargeHeader.swift
//  OnceUponAMeat
//
//  Created by Idan Israel on 04/08/2020.
//  Copyright © 2020 Idan Israel. All rights reserved.
//

import UIKit

/// MARK: - LargeHeaderProtocol
protocol LargeHeaderProtocol {
    /// MARK: - Functions
    
    func backPressed()
}

/// MARK: - LargeHeader

public class LargeHeader: UIView {
    /// MARK: - Outlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var headerHeightView: NSLayoutConstraint!
    @IBOutlet weak var titleBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleTralingConstraint: NSLayoutConstraint!
    @IBOutlet weak var navigationButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var navigationBarHorizontalConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var rightLabelButton: UIButton!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var leftLabelButton: UIButton!
    
    /// MARK: - Variables
    var delegate: LargeHeaderProtocol?
    
    /// MARK: - Actions
    @IBAction func buttonPressed(_ sender: UIButton) {
        self.delegate?.backPressed()
    }
    
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
        Bundle.main.loadNibNamed("LargeHeader", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [ .flexibleHeight, .flexibleWidth ]
        
        self.setButtonImage(imageName: "Back", color: .white, button: self.rightButton)
        self.setButtonImage(imageName: "Forward", color: .white, button: self.leftButton)
    }
    
    /// MARK: - Public Functions
    
    public func setButtonImage(imageName: String, color: UIColor, button: UIButton) {
        let origImage = UIImage(named: imageName)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        
        button.setImage(tintedImage, for: .normal)
        button.tintColor = color
    }
    
    public func enableBackButtton(vc: UIViewController, buttonTitle: String, isRight: Bool = true) {
        let selectedLabelButton = isRight ? self.rightLabelButton : self.leftLabelButton
        let selectedButton = isRight ? self.rightButton : self.leftButton
        
        self.delegate = vc as? LargeHeaderProtocol
        
        selectedLabelButton?.isHidden = false
        selectedButton?.isHidden = false
        
        selectedLabelButton?.setTitle(buttonTitle, for: .normal)
    }
}
