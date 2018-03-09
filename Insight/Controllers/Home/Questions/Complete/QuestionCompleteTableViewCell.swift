//
//  QuestionCompleteTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/4/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class QuestionCompleteTableViewCell: UITableViewCell {

    @IBOutlet var btnFlag: UIButton!
    @IBOutlet var tvAnswer: BorderedTV!
    @IBOutlet var tvVerb: BorderedTV!
    @IBOutlet var tvContent: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tvAnswer.layer.borderColor = UIColor.white.cgColor
        tvVerb.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
