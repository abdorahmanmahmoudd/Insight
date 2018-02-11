//
//  McqChoiceTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/5/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class McqChoiceTableViewCell: UITableViewCell {

    @IBOutlet var lblContent: UILabel!
    @IBOutlet var imgStatus: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            
            imgStatus.image = #imageLiteral(resourceName: "orangeCircle")
            lblContent.textColor = #colorLiteral(red: 1, green: 0.7244103551, blue: 0.2923497558, alpha: 1)
            
        }else {
            
            imgStatus.image = #imageLiteral(resourceName: "whiteCircle")
            lblContent.textColor = #colorLiteral(red: 0.0146472808, green: 0.1962190568, blue: 0.3836125135, alpha: 1)
        }
    }
    

}
