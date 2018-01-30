//
//  HomeViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 1/31/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setStyle()
        configuration()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setStyle(){
        
//        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func configuration(){
        
        SideMenuManager.shared.wire(to: self.navigationController!)
        configureMenuBtn()
    }

    func configureMenuBtn(){
        
        let btn = UIButton.init(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "icDrawer"), for: .normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(self.openMenu), for: .touchUpInside)
        let barBtn = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = barBtn
    }
    
    @objc func openMenu(){
        
        SideMenuManager.shared.show(from: self.navigationController!)
    }

}
