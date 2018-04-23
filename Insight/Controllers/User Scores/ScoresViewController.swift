//
//  ScoresViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/26/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class ScoresViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var lblNoResults: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var userScore = [ScoreData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndex = 5
    }
    
    func configuration(){
        
        self.title = "Results"
        addSideMenuBtn()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.tableFooterView = UIView()
        getUserScore()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userScore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as! ScoreTableViewCell
        
        cell.lblCategory.text = userScore[indexPath.row].category
        cell.lblUnit.text = userScore[indexPath.row].subCategory
        //handle subub category data
        cell.lblSection.attributedText = NSMutableAttributedString()
        var results = NSMutableAttributedString()
        for section in userScore[indexPath.row].subSubCategory{
            
            results.append(NSMutableAttributedString(string: section.name + "\n", attributes: [NSAttributedStringKey.foregroundColor : UIColor.black]))
            
            for i in 0..<section.scores.count{
                results.append(NSAttributedString(string:"   Your score \(i+1) : \(section.scores[i]) \n", attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)]))
            }
            
            results.append(NSAttributedString(string: "   Avg.score : \(section.averageScore)", attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)]))
        }
        cell.lblSection.attributedText = results
        
        return cell
    }
    
    func getUserScore(){
        
        showLoaderFor(view: self.view)
        
        let sm = ScoreModel()
        sm.getScore(complation: { (json,code) in
            
            hideLoaderFor(view: self.view)
            
            if let obj = json{
                
                if obj.data.count > 0{
                    self.userScore.append(contentsOf: obj.data)
                    self.tableView.reloadData()
                    self.lblNoResults.isHidden = true
                }else{
                    self.lblNoResults.isHidden = false
                }
                
            }else{
                self.lblNoResults.isHidden = false
            }
            
        }) { (error, msg) in
            self.lblNoResults.isHidden = false
            hideLoaderFor(view: self.view)
            showAlert(title: "Error", message: "Failed to get user score \n Please check your internet connection", vc: self, closure: nil)
        }

                
                hideLoaderFor(view: self.view)
    }

}
