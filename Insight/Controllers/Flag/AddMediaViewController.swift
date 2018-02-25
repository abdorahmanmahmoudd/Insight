//
//  AddMediaViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/24/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class AddMediaViewController: ParentViewController {
    
    var questionId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func configuration(){
        
        self.title = "Add Media"
    }
    
    @IBAction func btnAddPhotoClicked(_ sender: UIButton) {
        
        performSegue(withIdentifier: "AddPhotoSegue", sender: self)
    }
    @IBAction func btnAddNoteClicked(_ sender: UIButton) {
        
        performSegue(withIdentifier: "AddNoteSegue", sender: self)
    }
    
    @IBAction func btnAddVoiceNoteClicked(_ sender: UIButton) {
        
        performSegue(withIdentifier: "AddVoiceNoteSegue", sender: self)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "AddPhotoSegue"{
            
            if let des = segue.destination as? AddPhotoViewController{
                
                des.questionId = self.questionId
            }
        }else if segue.identifier == "AddNoteSegue"{
            
            if let des = segue.destination as? AddNoteViewController{
                
                des.questionId = self.questionId
            }
        }else if segue.identifier == "AddVoiceNoteSegue"{
            
            if let des = segue.destination as? AddVoiceNoteViewController{
                
                des.questionId = self.questionId
            }
        }
    }

}
