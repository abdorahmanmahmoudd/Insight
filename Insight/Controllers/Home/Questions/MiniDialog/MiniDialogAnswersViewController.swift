//
//  MiniDialogAnswersViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/17/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class MiniDialogAnswersViewController: UIViewController {

    @IBOutlet var lblFunctionB: UILabel!
    @IBOutlet var lblFunctionA: UILabel!
    @IBOutlet var lblSpeakerB: UILabel!
    @IBOutlet var lblSpeakerA: UILabel!
    @IBOutlet var lblPlace: UILabel!
    
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
        tvSpace.text = spaceText.html2String
        tvFunctionB.text = functionBText.html2String
        tvFunctionA.text = functionAText.html2String
        tvSpeakerB.text = speakerBText.html2String
        tvSpeakerA.text = speakerAText.html2String
        
        if spaceText == ""{
            lblPlace.isHidden = true
        }
        if speakerAText == ""{
            lblSpeakerA.isHidden = true
        }
        if speakerBText == ""{
            lblSpeakerB.isHidden = true
        }
        if functionAText == ""{
            lblFunctionA.isHidden = true
        }
        if functionBText == ""{
            lblFunctionB.isHidden = true
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnDismissClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
  

}
