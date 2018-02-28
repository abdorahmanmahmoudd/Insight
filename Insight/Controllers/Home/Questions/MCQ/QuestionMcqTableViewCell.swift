//
//  QuestionMcqTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/5/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class QuestionMcqTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet var tableChoices: UITableView!
    @IBOutlet weak var tvSubContent: UITextView!
    
    var choices = [String]()
    var correctAnswer = String()
    var showAnswer = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableChoices.estimatedRowHeight = 0
        tableChoices.rowHeight = UITableViewAutomaticDimension
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "McqChoiceCell", for: indexPath) as! McqChoiceTableViewCell
        
        cell.lblContent.text = choices[indexPath.row]
        
        if showAnswer {
            
            if correctAnswer == String(indexPath.row + 1){
             
                tableChoices.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
            }
        }
        
        return cell
    }



}
