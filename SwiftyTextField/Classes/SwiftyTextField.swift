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

@objc public protocol SwiftyTextFieldDelegate : class {
   @objc optional func textField(_ textField: SwiftyTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
   @objc optional func textFieldShouldEndEditing(_ textField: SwiftyTextField) -> Bool
   @objc optional func textFieldDidEndEditing(_ textField: SwiftyTextField)
   @objc optional func textFieldDidBeginEditing(_ textField: SwiftyTextField)
   @objc optional func textFieldShouldReturn(_ textField: SwiftyTextField) -> Bool
}

@IBDesignable
public class SwiftyTextField:UITextField{
  //MARK: - Variables -
  public var maximumTextLength:Int = 255
  public var currentTextFieldType:String = SwiftyTextFieldType.None.rawValue
  var delegateObj:SwiftyTextFieldDelegate?
  
  //MARK: - Initialization -
  override public init(frame: CGRect) {
    super.init(frame: frame)
    self.delegate = self
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.delegate = self
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
      self.configSwiftyTextField()
    }
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
   set textfield type like none, email, mobile, password, dateofbirth, postalcode
   */
  @IBInspectable public var TextFieldType:String?{
    didSet{
      if let textFieldType = SwiftyTextFieldType.init(rawValue: TextFieldType?.lowercased() ?? ""){
        self.currentTextFieldType = textFieldType.rawValue
      }
    }
  }
  
  //MARK: - Other functions -
  
  /*
   set keyboardtype based on textfield type, if textfieldtype is dateofbirth then open datepicker
   */
  public func configSwiftyTextField(){
    if(self.currentTextFieldType.lowercased() == SwiftyTextFieldType.DateOfBirth.rawValue){
      let datePicker = UIDatePicker()
      datePicker.datePickerMode = .date
      datePicker.maximumDate = Date()
      self.inputView = datePicker
      datePicker.addTarget(self, action: #selector(SwiftyTextField.changeDatePickerValue(_:)), for: .valueChanged)
    }else if(self.currentTextFieldType.lowercased() == SwiftyTextFieldType.PostalCode.rawValue){
      self.keyboardType = .numberPad
    }else if(self.currentTextFieldType.lowercased() == SwiftyTextFieldType.Mobile.rawValue){
      self.keyboardType = .phonePad
    }else if (self.currentTextFieldType.lowercased() == SwiftyTextFieldType.Password.rawValue){
      self.isSecureTextEntry = true
    }else if (self.currentTextFieldType.lowercased() == SwiftyTextFieldType.Email.rawValue){
      self.keyboardType = .emailAddress
    }
  }
  
  
  //Action for change datepicker-when textfield type is date of birth
  func changeDatePickerValue(_ sender:UIDatePicker)
  {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MMM-yyyy"
    dateFormatter.dateFormat = "dd-MMM-yyyy"
    self.text = dateFormatter.string(from: sender.date)
  }
  
  //MARK: - Email Validation -
  //check email validation if valid email id then return true otherwise return false
  func isValidEmail(email:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: email)
  }
  
  //MARK: - Mobile Validation -
  //check mobile/phone validation if valid Phone/mobile then return true otherwise return false
  func isValidMobile(lengthNumber:Int) -> Bool{
    let PHONE_REGEX = "^\\d{\(lengthNumber)}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: self)
    return result
  }
  
  //MARK: - Textfield methods -
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
    if(self.currentTextFieldType == SwiftyTextFieldType.PostalCode.rawValue || self.currentTextFieldType == SwiftyTextFieldType.Mobile.rawValue){
      if isValidTextField{
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        isValidTextField = (string == numberFiltered)
      }
    }
    if isValidTextField{
      if delegate != nil{
        isValidTextField = (delegate?.textField!(textField as! SwiftyTextField, shouldChangeCharactersIn: range, replacementString: string))!
      }
    }
    return isValidTextField
  }
  
  public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if (delegateObj != nil){
      delegateObj?.textFieldShouldEndEditing!(textField as! SwiftyTextField)
    }
    return true
  } 
  public func textFieldDidEndEditing(_ textField: UITextField) {
    if (delegateObj != nil){
      delegateObj?.textFieldDidEndEditing!(textField as! SwiftyTextField)
    }
  }
  
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    if (delegateObj != nil){
      delegateObj?.textFieldDidBeginEditing!(textField as! SwiftyTextField)
    }
  }
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    if (delegateObj != nil){
       return (delegateObj?.textFieldShouldReturn!(textField as! SwiftyTextField))!
    }
    return true
  }
  
  
}

