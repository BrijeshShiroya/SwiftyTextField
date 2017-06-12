//
//  ViewController.swift
//  SwiftyTextField
//
//  Created by BrijeshShiroya on 06/10/2017.
//  Copyright (c) 2017 BrijeshShiroya. All rights reserved.
//

import UIKit
import SwiftyTextField

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      //manual creation of textfield
      let txt:SwiftyTextField = SwiftyTextField.init(frame: CGRect.init(x: 50, y: 300, width: 200, height: 30))
      txt.backgroundColor = .red
      txt.LeftPadding = 20.0//left space
      txt.RightPadding = 20.0//right space
      txt.CornerRadius = 12.0//set corner radius
      txt.maximumTextLength = 12//set max length
      txt.TextFieldType = "postalcode"//settextfieldtype
      self.view.addSubview(txt)
      
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

