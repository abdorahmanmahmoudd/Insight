//
//  TrueFalseTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/9/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class TrueFalseTableViewCell: UITableViewCell {

    @IBOutlet var tvAnswer: UnderLinedTextView!
    @IBOutlet var btnTrue: UIButton!
    @IBOutlet var btnFalse: UIButton!
    @IBOutlet var tvContent: UITextView!
    @IBOutlet var btnFlag: flagBtn!
    
    var selectedAnswer = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnTrueClicked(_ sender: UIButton) {
        btnTrue.backgroundColor = UIColor.green
        btnFalse.backgroundColor = UIColor.clear
        selectedAnswer = 1
    }
    
    @IBAction func btnFalseClicked(_ sender: UIButton) {
        btnFalse.backgroundColor = UIColor.red
        btnTrue.backgroundColor = UIColor.clear
        selectedAnswer = 0
    }
}
