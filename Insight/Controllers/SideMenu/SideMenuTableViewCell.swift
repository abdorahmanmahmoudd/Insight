//
//  SideMenuTableViewCell.swift
//  MedicalDoctor
//
//  Created by abdelrahman.youssef on 1/25/18.
//  Copyright © 2018 HyperDesign. All rights reserved.
//

import UIKit
import Foundation

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
