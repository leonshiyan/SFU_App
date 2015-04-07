//
//  BreakMatchCell.swift
//  SFU_App
//
//  Created by Hugo Cheng on 4/7/15.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import UIKit
// Custom cell that displays friend and also friend status
class BMCell : UITableViewCell {
    
    @IBOutlet weak var Title: UILabel!
    
    @IBOutlet weak var StatusIcon: UIImageView!
   override init(style: UITableViewCellStyle, reuseIdentifier: String!){
        super.init(style: style,reuseIdentifier: reuseIdentifier)
    }

   required init(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
    
    
    
