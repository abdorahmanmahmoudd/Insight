//
//  LaunchScreenViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 1/29/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class LandViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        openLoginVC()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openLoginVC(){
        
        let sb = UIStoryboard.init(name: "Authentication", bundle: Bundle.main)
        
        if let vc = sb.instantiateViewController(withIdentifier: "AuthNav") as? UINavigationController{
            
//            self.view.window?.rootViewController = vc
            self.present(vc, animated: true, completion: nil)
        }
        
        
    }

}
