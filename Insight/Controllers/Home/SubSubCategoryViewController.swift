//
//  SubSubCategoryViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/1/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class SubSubCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableSubSubCategory: UITableView!
    
    var subsubCaterogies = [SubSubCategory]()
    var selectedSubSubCategory = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subsubCaterogies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubSubCell", for: indexPath) as! SubSubCategoryTableViewCell
        
        cell.configureCell(data : subsubCaterogies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedSubSubCategory = indexPath.row
        performSegue(withIdentifier: "QuestionsContainerSegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "QuestionsContainerSegue"{
            
            if let des = segue.destination as? QuestionsContainerViewController{
                
                des.subsubCategory = subsubCaterogies[selectedSubSubCategory]
            }
        }
    }
    
}
