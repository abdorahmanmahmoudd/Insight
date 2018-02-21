//
//  SubClass.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/2/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class UnderLinedTextField :  UITextField {
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.clear.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
    }
    
}

class BorderedTV :  UITextView {
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        self.layer.masksToBounds = true
        layer.cornerRadius = 6
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        
    }
    
}

class UnderLinedTextView :  UITextView {
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        self.backgroundColor = UIColor.clear
    
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
}


class BlackUnderLinedTextView :  UITextView {
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
    }
    
}

class IntinsicTableView : UITableView {
    
    override var contentSize: CGSize{
        didSet{
                self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize{
        self.layoutIfNeeded()
        return CGSize.init(width: UIViewNoIntrinsicMetric, height: contentSize.height)
    }
    
    
}

class flagBtn : UIButton {
    
    var questionId = String()
    var flagValue = 0
    
}

