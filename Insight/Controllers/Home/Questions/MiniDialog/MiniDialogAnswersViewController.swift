//
//  MiniDialogAnswersViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/17/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class MiniDialogAnswersViewController: UIViewController {

    @IBOutlet var tvFunctionB: UITextView!
    @IBOutlet var tvFunctionA: UITextView!
    @IBOutlet var tvSpeakerB: UITextView!
    @IBOutlet var tvSpeakerA: UITextView!
    @IBOutlet var tvSpace: UITextView!
    
    var spaceText = String()
    var speakerAText = String()
    var speakerBText = String()
    var functionAText = String()
    var functionBText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tvFunctionB.text = functionBText.html2String
        tvFunctionA.text = functionAText.html2String
        tvSpeakerB.text = speakerBText.html2String
        tvSpeakerA.text = speakerAText.html2String
        tvSpace.text = spaceText.html2String
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnDismissClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
  

}
