//
//  FreeWritingTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/27/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class FreeWritingTableViewCell: UITableViewCell {
    
    @IBOutlet var tvContent: UITextView!
    @IBOutlet var tvAnswer: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
