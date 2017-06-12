# SwiftyTextField

[![CI Status](http://img.shields.io/travis/BrijeshShiroya/SwiftyTextField.svg?style=flat)](https://travis-ci.org/BrijeshShiroya/SwiftyTextField)
[![Version](https://img.shields.io/cocoapods/v/SwiftyTextField.svg?style=flat)](http://cocoapods.org/pods/SwiftyTextField)
[![License](https://img.shields.io/cocoapods/l/SwiftyTextField.svg?style=flat)](http://cocoapods.org/pods/SwiftyTextField)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyTextField.svg?style=flat)](http://cocoapods.org/pods/SwiftyTextField)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Menual installation

Make SwiftyTextFielf programatically

```ruby
let txtfield:SwiftyTextField = SwiftyTextField.init(frame: CGRect.init(x: X, y: Y, width: WIDTH, height: HEIGHT))
      txtfield.backgroundColor = .red
      txtfield.LeftPadding = LEFTSPACE//left space
      txtfield.RightPadding = RIGHTSPACE//right space
      txtfield.CornerRadius = CORNERRADIUS//set corner radius
      txtfield.maximumTextLength = LENGTH//set max length
      txtfield.TextFieldType = TYPE//SwiftyTextFieldType.DateOfBirth.rawValue//settextfieldtype
      txtfield.configSwiftyTextField()
      self.view.addSubview(txtfield)
```

## Installation

SwiftyTextField is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftyTextField"
```

## Author

BrijeshShiroya, brijesh281994@gmail.com

## License

SwiftyTextField is available under the MIT license. See the LICENSE file for more info.
