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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
