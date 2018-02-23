//
//  MitakesTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/8/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class MistakesTableViewCell: UITableViewCell {
    
    @IBOutlet var tvMistake: BorderedTV!
    @IBOutlet var btnAddMistake: UIButton!
    @IBOutlet var tvAnswer: BorderedTV!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tvMistake.layer.borderColor = UIColor.red.cgColor
        tvAnswer.layer.borderColor = UIColor.green.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnAddMistakeClicked(_ sender: UIButton) {
        
        
    }
}
