//
//  SubCategoryViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/1/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class SubCategoryViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableSubCategory: UITableView!
    @IBOutlet var lblNoResults : UILabel!
    
    var homeItemId = 0
    var subCategory = [SubCategory]()
    var titleText = String()
    var flagFilter : Flag?
    var selectedSubCategory = Int()
    
    var allSubsUnlocked = false
    var unlockedSubsIds = [Int]()
    
    var pkgs = [UserPackageItem]()
    
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
        if subCategory.count == 0 {
            lblNoResults.isHidden = false
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCell", for: indexPath) as! SubCategoryTableViewCell
        
        if allSubsUnlocked {
            subCategory[indexPath.row].locked = false
        }else{
            if unlockedSubsIds.contains(subCategory[indexPath.row].id){
                subCategory[indexPath.row].locked = false
            }else{
                subCategory[indexPath.row].locked = true
            }
        }
        cell.configureCell(data : subCategory[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if !subCategory[indexPath.row].locked{
            ParentViewController.currentQParentParentId = subCategory[indexPath.row].id
            selectedSubCategory = indexPath.row
            performSegue(withIdentifier: "SubSubCategorySegue", sender: nil)
        }else{
            
            showYesNoAlert(title: "", message: "Please subscribe to open Sub categories", vc: self, closure: { (yes) in
                if yes{
                    
                    let sb = UIStoryboard.init(name: "Subscribtion", bundle: Bundle.main)
                    let viewController = sb.instantiateViewController(withIdentifier: "SubscribeVC")
                    self.navigationController?.setViewControllers([viewController], animated: true)
                }
            })
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SubSubCategorySegue" {
            
            if let des = segue.destination  as? SubSubCategoryViewController{
                
                des.subsubCaterogies = subCategory[selectedSubCategory].subSubCategory
                des.subCategoryId = subCategory[selectedSubCategory].id
                des.homeItemId = homeItemId
                
                if let flag = self.flagFilter{
                    des.flagFilter = flag
                    
                    do {
                        
                        let flaggedQuestions = realm?.objects(FlaggedQuestion.self)
                        
                        des.subsubCaterogies = des.subsubCaterogies.filter({ (subSubCategory) -> Bool in
                            
                            if let questionsParentIDs = flaggedQuestions?.map ({ $0.parentId }) {
                                
                                return questionsParentIDs.contains(String(subSubCategory.id))
                            }
                            return false
                        })
                        
                    }catch let err {
                        
                        showAlert(title: "", message: err.localizedDescription, vc: self, closure: nil)
                    }
                    
                }
            }
        }
    }

}
