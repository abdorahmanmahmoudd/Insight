//
//  AntonymQViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/2/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class AntonymQViewController: UIViewController {

    @IBOutlet var btnShowAnswer: UIButton!
    @IBOutlet var tfsAnswers: [UnderLinedTextField]!
    @IBOutlet var lblsQuestions: [UILabel]!
    
    var question : Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnShowAnswerClicked(_ sender: UIButton) {
        
    }
    
    

}
