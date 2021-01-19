//
//  CustomTextField.swift
//  FirestoreChat
//
//  Created by Muhammad Ario Bagus on 18/01/21.
//

import UIKit

class CustomTextField: UITextField {
    init(Placeholder : String) {
        super.init(frame: .zero)
        
        borderStyle = .none
        font = UIFont.systemFont(ofSize: 16)
        textColor = .white
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: Placeholder, attributes: [.foregroundColor : UIColor.white])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


