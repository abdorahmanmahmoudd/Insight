//
//  FlagViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/20/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class FlagViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addSideMenuBtn()
        confiuration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedIndex = 3
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func confiuration(){
        
        self.title = "Flagged"
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Flag.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlagCell", for: indexPath) as! FlagTableViewCell
        
        cell.lblFlag.text = Flag(rawValue: indexPath.row + 1)?.string
        cell.imgFlag.image = UIImage.init(named: Flag(rawValue: indexPath.row + 1)?.string ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedFlag = Flag(rawValue: indexPath.row)
        print(selectedFlag?.string)
    }
    

}
