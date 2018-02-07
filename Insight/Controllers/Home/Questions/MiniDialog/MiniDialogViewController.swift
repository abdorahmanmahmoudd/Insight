//
//  MiniDialogViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/7/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class MiniDialogViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var tableView: IntinsicTableView!
    
    var questions = [QuestionData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionMiniDialogCell", for: indexPath) as! MiniDialogTableViewCell
        
        cell.tvContent.text = questions[indexPath.row].content
        
        return cell
    }

    @IBAction func BtnShowAnswerClicked(_ sender: UIButton) {
    }
}
