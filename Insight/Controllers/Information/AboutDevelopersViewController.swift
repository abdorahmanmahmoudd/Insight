//
//  AboutDevelopersViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/8/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class AboutDevelopersViewController: ParentViewController {

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
        
        selectedIndex = 7
        self.title = "About Developers"
        addSideMenuBtn()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
