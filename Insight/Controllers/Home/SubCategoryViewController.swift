//
//  SubCategoryViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/1/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class SubCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableSubCategory: UITableView!
    
    var subCategory = [SubCategory]()
    var titleText = String()
    
    var selectedSubCategory = Int()
    
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
        
        self.title = titleText
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCell", for: indexPath) as! SubCategoryTableViewCell
        
        cell.configureCell(data : subCategory[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !subCategory[indexPath.row].locked{
        
            selectedSubCategory = indexPath.row
            performSegue(withIdentifier: "SubSubCategorySegue", sender: nil)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SubSubCategorySegue" {
            
            if let des = segue.destination  as? SubSubCategoryViewController{
                
                des.subsubCaterogies = subCategory[selectedSubCategory].subSubCategory
            }
        }
    }

}
