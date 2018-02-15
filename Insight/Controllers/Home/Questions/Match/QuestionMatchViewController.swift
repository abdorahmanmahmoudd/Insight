//
//  QuestionMatchViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/5/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class QuestionMatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var btnShowAnswer: UIButton!
    @IBOutlet var tableView: IntinsicTableView!
    
    var questions = [QuestionData]()
    var showAnswer = false
    
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
        
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if showAnswer{
            
            btnShowAnswer.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionMatchCell", for: indexPath) as! QuestionMatchTableViewCell
        
        cell.fillData(question: questions[indexPath.row])
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MatchAnswerSegue"{
            
            if let des = segue.destination as? QuestionMatchViewController{
                
                des.showAnswer = true
                des.questions = self.questions
            }
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
