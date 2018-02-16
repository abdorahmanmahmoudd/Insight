//
//  TrueFalseViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/9/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class TrueFalseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UITextViewDelegate{
    
    @IBOutlet var btnShowAnswer: UIButton!
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
    
    func configuration(){
    
        tableView.rowHeight = 112
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTrueFlaseCell", for: indexPath) as! TrueFalseTableViewCell
        
        cell.tvContent.text = questions[indexPath.row].content
        
        return cell
    }
    
    func textViewDidChange(_ textView: UITextView) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text.removeAll()
    }
}
