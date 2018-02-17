//
//  GeneralQuestionAnswersViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/17/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class GeneralQuestionAnswersViewController: UIViewController {

    @IBOutlet var tvAnswer: UITextView!
    
    var answerText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tvAnswer.text = answerText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnDismissClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    

}
