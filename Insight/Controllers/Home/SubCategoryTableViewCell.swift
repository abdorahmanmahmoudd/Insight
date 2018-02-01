//
//  SubTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/1/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class SubCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var btnUnlock: UIButton!
    @IBOutlet var imgLockStatus: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data : SubCategory){
        
        lblTitle.text =  data.name
        
        if data.locked{
            
            lblTitle.textColor = ColorlockedSubItemGray
            imgLockStatus.image = #imageLiteral(resourceName: "locked")
            btnUnlock.setImage(#imageLiteral(resourceName: "unlock"), for: .normal)
            
        }else{
            
            lblTitle.textColor = ColorUnlockedSubItemDarkGray
            imgLockStatus.image = #imageLiteral(resourceName: "unlocked")
            btnUnlock.setImage(nil, for: .normal)
        }
        
    }

}
