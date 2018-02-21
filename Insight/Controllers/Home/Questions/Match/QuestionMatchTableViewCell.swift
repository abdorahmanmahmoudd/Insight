//
//  QuestionMatchTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/5/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class QuestionMatchTableViewCell: UITableViewCell {
    
    @IBOutlet var btnFlag: UIButton!
    @IBOutlet var tfAnswerNumber: UITextField!
    @IBOutlet var viewContent: UIView!
    @IBOutlet var viewAnswer: UIView!
    @IBOutlet var tvContent: UITextView!
    @IBOutlet var tvAnswer: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setStyle(){
        
        viewContent.layer.borderColor = UIColor.white.cgColor
        viewContent.layer.borderWidth = 2
        viewAnswer.layer.borderColor = UIColor.white.cgColor
        viewAnswer.layer.borderWidth = 2
    }
    
    func fillData(question : QuestionData){
        
        tvContent.text = question.content.html2String
        tvAnswer.text = question.answer.html2String
    }

}
