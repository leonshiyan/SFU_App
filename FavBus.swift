//
//  FavBus.swift
//  SFU_App
//
//  Created by Hugo Cheng on 2015-03-30.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import CoreData

class FavBus: NSManagedObject {

    @NSManaged var busnum: String
    @NSManaged var tag: String

}
