//
//  ResultsViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/23/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit
import UICircularProgressRing

class ResultsViewController: UIViewController {

    @IBOutlet var viewAppAvgResults: UICircularProgressRingView!
    @IBOutlet var viewUserResults: UICircularProgressRingView!
    
    var userResult = CGFloat()
    var appAvg = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuration(){
        
        self.title = "Results"
        viewUserResults.ringStyle = .inside
        viewAppAvgResults.ringStyle = .inside
        viewUserResults.font = getFont(25, MavenProMedium)
        viewAppAvgResults.font = getFont(25, MavenProMedium)
        
    }
    
    func startAnimation(){
        
        viewUserResults.setProgress(value: userResult, animationDuration: TimeInterval.init(2))
        viewAppAvgResults.setProgress(value: appAvg, animationDuration: TimeInterval.init(2))
    }
    
    @IBAction func btnDoneClicked(_ sender: UIButton) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}
