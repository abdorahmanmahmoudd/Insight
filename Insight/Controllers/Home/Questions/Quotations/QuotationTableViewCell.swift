//
//  QuotationTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/9/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class QuotationTableViewCell: UITableViewCell {

    @IBOutlet var tvAnswer: UITextView!
    @IBOutlet var tvContent: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}