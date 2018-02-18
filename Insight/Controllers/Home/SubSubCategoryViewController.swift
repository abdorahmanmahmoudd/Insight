//
//  SubSubCategoryViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/1/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class SubSubCategoryViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        if subsubCaterogies[selectedSubSubCategory].questions != nil && subsubCaterogies[selectedSubSubCategory].questions.count > 0 && subsubCaterogies[selectedSubSubCategory].questions[0].type ?? "" == QuestionTypes.Listening.rawValue{
            
            performSegue(withIdentifier: "QuestionListeningSegue", sender: nil)
            
        }else  {
            
            performSegue(withIdentifier: "QuestionsContainerSegue", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "QuestionsContainerSegue"{
            
            if let des = segue.destination as? QuestionsContainerViewController{
                
                des.subsubCategory = subsubCaterogies[selectedSubSubCategory]
            }
        }else if segue.identifier == "QuestionListeningSegue"{
            
            if let des = segue.destination as? QuestionListeningViewController{
                
                des.questions = subsubCaterogies[selectedSubSubCategory].questions[0].data
            }
        }
    }
    
}
