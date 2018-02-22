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
    var flagFilter : Flag?

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
                
                if flagFilter == nil {
                    des.subsubCategory = subsubCaterogies[selectedSubSubCategory]
                    
                }else{
                
                    do {
                        let predicateQuery = NSPredicate.init(format: "flagValue == %@", flagFilter?.rawValue ?? 0)
                        
                        let flaggedQuestions = realm?.objects(FlaggedQuestion.self).filter(predicateQuery)
                        
                        if let questionsIDs = flaggedQuestions?.map({ (item) -> String in
                            item.Id
                        }){
                            
                            let filteredQuestions = subsubCaterogies[selectedSubSubCategory].questions.filter({ (question) -> Bool in
                                questionsIDs.contains(String(question.id))
                            })
                            subsubCaterogies[selectedSubSubCategory].questions = filteredQuestions
                            des.subsubCategory = subsubCaterogies[selectedSubSubCategory]
                            
                        }else{
                            
                            des.subsubCategory = subsubCaterogies[selectedSubSubCategory]
                        }
                        
                    }catch let err {
                        
                        showAlert(title: "", message: err.localizedDescription, vc: self, closure: nil)
                    }
                    
                }
                
            }
        }else if segue.identifier == "QuestionListeningSegue"{
            
            if let des = segue.destination as? QuestionListeningViewController{
                
                des.questions = subsubCaterogies[selectedSubSubCategory].questions[0].data
            }
        }
    }
    
}
