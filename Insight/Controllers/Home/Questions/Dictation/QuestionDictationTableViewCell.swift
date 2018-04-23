//
//  QuestionDictationTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/4/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class QuestionDictationTableViewCell: UITableViewCell {

    @IBOutlet var btnFlag: UIButton!
    @IBOutlet var tvAnswer: BlackUnderLinedTextView!
    @IBOutlet var tvContent: UITextView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tvAnswer.textContainer.maximumNumberOfLines = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
