//
//  CustomTextField.swift
//  ChatApp
//
//  Created by Tamirlan Aubakirov on 17.08.2022.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placehodler: String){
        super.init(frame: .zero)
        
        borderStyle = .none
        font = UIFont.systemFont(ofSize: 16)
        textColor = .white
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placehodler, attributes: [.foregroundColor: UIColor.white])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
