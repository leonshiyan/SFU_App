//
//  Friend.swift
//  SFU_App
//
//  Created by Hugo Cheng on 2015-03-30.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import CoreData

class Friend: NSManagedObject {

    @NSManaged var userid: String
    @NSManaged var email: String
    @NSManaged var sch: String

}
