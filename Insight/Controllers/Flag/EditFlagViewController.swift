//
//  EditFlagViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/20/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit
import RealmSwift

class EditFlagViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var btnAddMedia: UIButton!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var flagValue = 0
    var questionId = String()
    var indexPath = IndexPath()
    var notificationName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
        print("\(realm!.objects(FlaggedQuestion.self))")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuration(){
        
        self.title = "Flag"
        if let flagCellIndex = Flag(rawValue: flagValue)?.rawValue {
            
            tableView.selectRow(at: IndexPath(row: flagCellIndex - 1, section: 0), animated: true, scrollPosition: .none)
        }
    }
    
    @IBAction func btnAddMediaClicked(_ sender: UIButton) {
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        
        saveQuestion()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Flag.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditFlagCell", for: indexPath) as! EditFlagTableViewCell
        
        cell.lblFlag.text = Flag(rawValue: indexPath.row + 1)?.string
        cell.imgFlag.image = UIImage.init(named: Flag(rawValue: indexPath.row + 1)?.string ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        flagValue = Flag(rawValue: indexPath.row + 1)?.rawValue ?? 0
    }
    
    func saveQuestion(){
    
        let q = FlaggedQuestion()
        q.flagValue = flagValue
        q.Id = questionId
        
        do {
            
            try? realm?.write {
                realm?.add(q, update: true)
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationName ), object: nil, userInfo: ["indexPath":indexPath])
            
        }catch let err {
            showAlert(title: "", message: err.localizedDescription, vc: self, closure: nil)
        }
        
    
    }
    


}
