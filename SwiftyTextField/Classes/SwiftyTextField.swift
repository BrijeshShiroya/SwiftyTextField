//
//  SwiftyTextField.swift
//  Pods
//
//  Created by Brijesh on 10/06/17.
//
//

import Foundation
import UIKit

class SwiftyTextField: UITextField {
    
    //MARK: - Initialization -
    override public init(frame: CGRect) {
        super.init(frame: frame)
     }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func awakeFromNib() {
    }
}
