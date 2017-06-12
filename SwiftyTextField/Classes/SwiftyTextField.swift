//
//  SwiftyTextField.swift
//  Pods
//
//  Created by Shiroya&Bros on 10/06/17.
//
//
import Foundation
import UIKit
@IBDesignable
public class SwiftyTextField:UITextField{
    //MARK: - Variables -
    public var _leftPadding:CGFloat = 0.0
    public var _rightPadding:CGFloat = 0.0
    
    //MARK: - Initialization -
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - IBInspactable -
    /*
     This property set corner radius of textfield .
     If user not give any valur to this property then default valur is 0.0 .If user set value then apply on it.
     */
    @IBInspectable public var CornerRadius:CGFloat = 0.0{
        didSet{
            self.layer.cornerRadius = CornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    
    /*
     LeftPadding set left space of textfield that means front space is set and when user start writing into textfield, writing is start after leftspace into textfield.
     */
    @IBInspectable public var LeftPadding:CGFloat = 0.0{
        didSet{
            self._leftPadding = LeftPadding
        }
    }
    
    /*
     RightPadding set right space of textfield that means rear space is set and when user start writing into textfield, writing is start after rightspace into textfield.
     */
    @IBInspectable public var RightPadding:CGFloat = 0.0{
        didSet{
            self._rightPadding = RightPadding
        }
    }
    
    
    /*
     set left,right,bottom and top space into textfield. Set four side space when user editing or after editing or before editing.
     */
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets.init(top: 0, left: self._leftPadding, bottom: 0.0, right: self._rightPadding))
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets.init(top: 0, left: self._leftPadding, bottom: 0.0, right: self._rightPadding))
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets.init(top: 0, left: self._leftPadding, bottom: 0.0, right: self._rightPadding))
    }
}

