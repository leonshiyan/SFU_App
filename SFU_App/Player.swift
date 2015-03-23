//
//  Player.swift
//  SFU_App
//
//  Created by Hugo Cheng on 2015-03-23.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import UIKit

class Player: NSObject {
    var name:String
    var number:String
    
    init(name:String, number:String) {
        self.name = name
        self.number = number
        super.init()
    }
}