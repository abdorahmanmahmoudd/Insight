//
//  AboutAppViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/8/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class AboutAppViewController: ParentViewController {

    
    @IBOutlet var tvParagraph : UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuration(){
        
        selectedIndex = 6
        self.title = "About App"
        addSideMenuBtn()
    }


}
