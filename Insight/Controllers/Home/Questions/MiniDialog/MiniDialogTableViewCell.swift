//
//  MiniDialogTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/7/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class MiniDialogTableViewCell: UITableViewCell {

    @IBOutlet var tvFunctionBA: UITextView!
    @IBOutlet var tvFunctionAA: UITextView!
    @IBOutlet var tvSpeakerBA: UITextView!
    @IBOutlet var tvSpeakerAA: UITextView!
    @IBOutlet var tvPlaceAnswer: UITextView!
    @IBOutlet var tvContent: UITextView!
    
    var cellIndex = Int()
    
    var showAnswerHandler : ((MiniDialogTableViewCell) -> ())?
    
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
