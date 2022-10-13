//
//  TextFieldCell.swift
//  Calorish
//
//  Created by admin on 16.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol TextFieldViewModel {
    var text: String { get }
    var placeholder: String { get }
}

@IBDesignable
class TextFieldView: UIView {
    
    @IBOutlet private var view: UIView!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var backgroundView: UIView!
    
    var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 10
        
        backgroundColor = .clear
        view.backgroundColor = .clear
    }
    
    private func setup() {
        Bundle.main.loadNibNamed("TextFieldView", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setup(with viewModel: TextFieldViewModel) {
        textField.text = viewModel.text
        textField.placeholder = viewModel.placeholder
    }
    
    func addTarget(_ target: Any?, action: Selector, controlEvent: UIControl.Event) {
        textField.addTarget(target, action: action, for: controlEvent)
    }
}
