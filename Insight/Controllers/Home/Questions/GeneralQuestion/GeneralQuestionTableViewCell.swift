//
//  GeneralQuestionTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/8/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class GeneralQuestionTableViewCell: UITableViewCell {

    @IBOutlet var tvAnswer: UnderLinedTextView!
    @IBOutlet var tvContent: UITextView!
    
    var cellIndex = Int()
    
    var showAnswerHandler : ((GeneralQuestionTableViewCell) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnShowAnswerClicked(_ sender: UIButton) {
        showAnswerHandler!(self)
    }
}
