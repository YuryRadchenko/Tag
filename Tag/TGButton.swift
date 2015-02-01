//
//  TGButton.swift
//  Tag
//
//  Created by yury on 01.02.15.
//  Copyright (c) 2015 Step. All rights reserved.
//

/*
Класс игровой кнопки
*/

import Foundation
import UIKit

class TGButton: UIButton {
    var cell: TGGameFieldCell?
    
    func styleButtonNormal() {
        self.backgroundColor = UIColor.lightGrayColor()
        self.layer.borderColor = UIColor.blueColor().CGColor
        self.layer.borderWidth = 1
        self.titleLabel?.textColor = UIColor.whiteColor()
    }
    
    func styleButtonEmpty() {
        self.backgroundColor = UIColor.whiteColor()
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.layer.borderWidth = 1
        self.titleLabel?.textColor = UIColor.clearColor()
    }
    
}