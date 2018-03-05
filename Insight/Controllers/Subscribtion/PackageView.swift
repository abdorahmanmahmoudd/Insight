//
//  PackageView.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/4/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class PackageView: UICollectionViewCell {

    @IBOutlet var btnSubscribe: UIButton!
    @IBOutlet var lblPkgSections: UILabel!
    @IBOutlet var lblPkgCategories: UILabel!
    @IBOutlet var lblPkgUnits: UILabel!
    @IBOutlet var lblPkgTitle: UILabel!
    @IBOutlet var lblPgkName: UILabel!
        
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
 
    @IBAction func btnSubscribeClicked(_ sender: UIButton) {
        
    }
    
}
