//
//  QuestionAntonymTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/4/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class QuestionAntonymTableViewCell: UITableViewCell {

    @IBOutlet var tvAnswer: UnderLinedTextView!
    @IBOutlet var tvContent: UITextView!
    @IBOutlet var btnFlag: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnFlagClicked(_ sender: UIButton) {
    }
    
}
