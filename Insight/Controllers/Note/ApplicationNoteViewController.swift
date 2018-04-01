//
//  ApplicationNoteViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/7/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class ApplicationNoteViewController: ParentViewController, UITextViewDelegate {

    @IBOutlet var tvNote: BorderedTV!
    
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
        
        self.title = "Note"
        tvNote.layer.borderColor = UIColor.white.cgColor
        addSideMenuBtn()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissView (_:)))
        self.view.addGestureRecognizer(tapGesture)
        getNoteIfExists()
    }
    
    @objc func dismissView (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        
        showLoaderFor(view: self.view)
        
        let text = tvNote.text
        
        UserDefaults.standard.set(text, forKey: UserModel.getInstance.getUser()?.user.email ?? InsightAppNoteKey)
        UserDefaults.standard.synchronize()
        
        hideLoaderFor(view: self.view)
        
        
        let sb = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        let viewController = sb.instantiateViewController(withIdentifier: "HomeVC")
        self.navigationController?.setViewControllers([viewController], animated: true)
        
    }
    
    func getNoteIfExists(){
        
        let string = UserDefaults.standard.string(forKey: UserModel.getInstance.getUser()?.user.email ?? InsightAppNoteKey)
        if string != nil
        {
            tvNote.text = string
        }
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
