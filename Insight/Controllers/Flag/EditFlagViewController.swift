//
//  EditFlagViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/20/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class EditFlagViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var btnAddMedia: UIButton!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var flagValue = 0
    var questionId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
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
    }
    
    @IBAction func btnAddMediaClicked(_ sender: UIButton) {
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
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
    


}
