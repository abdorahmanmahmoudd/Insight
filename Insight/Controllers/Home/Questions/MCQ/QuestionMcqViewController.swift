//
//  QuestionMcqViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/5/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class QuestionMcqViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableQuestions: IntinsicTableView!
    @IBOutlet var btnShowAnswer: UIButton!
    
    var questions = [QuestionData]()
    
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
        
        tableQuestions.sectionHeaderHeight = UITableViewAutomaticDimension
        tableQuestions.estimatedSectionHeaderHeight = 300
        
        tableQuestions.rowHeight = UITableViewAutomaticDimension
        tableQuestions.estimatedRowHeight = 500
        
        tableQuestions.register(UINib.init(nibName: "QuestionGeneralHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "QuestionGeneralHeader")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableQuestions.dequeueReusableHeaderFooterView(withIdentifier: "QuestionGeneralHeader")
        
        (headerView as? GeneralTableViewHeader)?.tvContent.text = questions[section].content
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[section].choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionMcqCell", for: indexPath) as! QuestionMcqTableViewCell
        
        cell.choices = questions[indexPath.section].choices[indexPath.row].choices
        
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
