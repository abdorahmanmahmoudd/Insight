//
//  EditFlagTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/20/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class EditFlagTableViewCell: UITableViewCell {
    @IBOutlet var imgFlag: UIImageView!
    @IBOutlet var lblFlag: UILabel!
    @IBOutlet var btnFlagSelected: UIButton!
    
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
