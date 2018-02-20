//
//  FlagTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/20/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class FlagTableViewCell: UITableViewCell {

    @IBOutlet var lblFlag: UILabel!
    @IBOutlet var imgFlag: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
