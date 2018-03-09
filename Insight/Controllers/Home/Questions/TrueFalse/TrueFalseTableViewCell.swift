//
//  TrueFalseTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/9/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class TrueFalseTableViewCell: UITableViewCell {

    @IBOutlet var tvAnswer: UITextView!
    @IBOutlet var btnTrue: UIButton!
    @IBOutlet var btnFalse: UIButton!
    @IBOutlet var tvContent: UITextView!
    @IBOutlet var btnFlag: flagBtn!
    
    var selectedAnswer = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    @IBAction func btnTrueClicked(_ sender: UIButton) {
        btnTrue.setBackgroundImage(#imageLiteral(resourceName: "t_greens"), for: .normal)
        btnFalse.setBackgroundImage(#imageLiteral(resourceName: "matchQuesTF-BG"), for: .normal)
        selectedAnswer = 1
    }
    
    @IBAction func btnFalseClicked(_ sender: UIButton) {
        btnFalse.setBackgroundImage(#imageLiteral(resourceName: "f_reds"), for: .normal)
        btnTrue.setBackgroundImage(#imageLiteral(resourceName: "matchQuesTF-BG"), for: .normal)
        selectedAnswer = 0
    }
}
