//
//  SwiftyTextField.swift
//  Pods
//
//  Created by Shiroya&Bros on 10/06/17.
//
//
import Foundation
import UIKit

public enum SwiftyTextFieldType: String{
  case None = "none"
  case Email = "email"
  case Mobile = "mobile"
  case Password = "password"
  case DateOfBirth = "dateofbirth"
  case PostalCode = "postalcode"
}


@IBDesignable
public class SwiftyTextField:UITextField{
  //MARK: - Variables -
  public var maximumTextLength:Int = 255
  public var currentTextFieldType:String = SwiftyTextFieldType.None.rawValue
  
  //MARK: - Initialization -
  override public init(frame: CGRect) {
    super.init(frame: frame)
    self.delegate = self
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.delegate = self
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
    }
  }
  
  /*
   RightPadding set right space of textfield that means rear space is set and when user start writing into textfield, writing is start after rightspace into textfield.
   */
  @IBInspectable public var RightPadding:CGFloat = 0.0{
    didSet{
    }
  }
  
  /*
   MaxLength is set limitation of user input.when user wants set limitation of input in textfield that time user set this value
   */
  @IBInspectable public var MaxLength:Int = 255{
    didSet{
      if (MaxLength != 0){
        self.maximumTextLength = MaxLength
      }
    }
  }
  
  /*
   set textfield type like none,email,mobile, password,dateofbirth, postalcode
   */
  @IBInspectable public var TextFieldType:String?{
    didSet{
      if let textFieldType = SwiftyTextFieldType.init(rawValue: TextFieldType?.lowercased() ?? ""){
        self.currentTextFieldType = textFieldType.rawValue
      }
    }
  }
  
  
  //MARK: - Email Validation
  //check email validation if valid email id then return true otherwise return false
  func isValidEmail(email:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: email)
  }
  
  //MARK: - Mobile Validation
  //check mobile/phone validation if valid Phone/mobile then return true otherwise return false
  func isValidMobile(lengthNumber:Int) -> Bool{
    let PHONE_REGEX = "^\\d{\(lengthNumber)}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: self)
    return result
  }
  
  /*
   set left,right,bottom and top space into textfield. Set four side space when user editing or after editing or before editing.
   */
  override public func textRect(forBounds bounds: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets.init(top: 0, left: self.LeftPadding, bottom: 0.0, right: self.RightPadding))
  }
  
  override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets.init(top: 0, left: self.LeftPadding, bottom: 0.0, right: self.RightPadding))
  }
  
  override public func editingRect(forBounds bounds: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets.init(top: 0, left: self.LeftPadding, bottom: 0.0, right: self.RightPadding))
  }
}


//MARK: - Textfield Delegates -
extension SwiftyTextField:UITextFieldDelegate{
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    var isValidTextField:Bool = true
    let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
    let strTrimmed = (NSString(string:newString)).trimmingCharacters(in: CharacterSet.whitespaces)//remove white space
    isValidTextField = strTrimmed.characters.count <= self.maximumTextLength
    if(self.TextFieldType == SwiftyTextFieldType.PostalCode.rawValue || self.currentTextFieldType == SwiftyTextFieldType.Mobile.rawValue){
      if isValidTextField{
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        isValidTextField = (string == numberFiltered)
      }
    }
    return isValidTextField
  }
}

