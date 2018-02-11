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
    
    var choices = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configuration()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configuration(){
    
        tableChoices.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "McqChoiceCell", for: indexPath) as! McqChoiceTableViewCell
        
        cell.lblContent.text = choices[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //handle selection
        
    }

}
