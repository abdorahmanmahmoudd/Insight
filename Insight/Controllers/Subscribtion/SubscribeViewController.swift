//
//  SubscribeViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/4/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class SubscribeViewController: ParentViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var viewPkgs: UIView!
    @IBOutlet var viewUserPkgs: UIView!
    @IBOutlet var collectionViewUserPackages: UICollectionView!
    @IBOutlet var viewNoCurrentPkg: UIView!
    @IBOutlet var lblNoResultsPackages: UILabel!
    @IBOutlet var collectionViewPackages: UICollectionView!
    
    var userPackages = [PackageRootClass]()
    var packages = [PackageRootClass]()
    var selectedPackageIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndex = 2
        
    }
    
    func configuration(){
        
        self.title = "Subscribe"
        addSideMenuBtn()
        collectionViewPackages.register(UINib.init(nibName: "Package", bundle: Bundle.main), forCellWithReuseIdentifier: "PackageView")
        collectionViewUserPackages.register(UINib.init(nibName: "Package", bundle: Bundle.main), forCellWithReuseIdentifier: "PackageView")
        
        viewNoCurrentPkg.layer.borderWidth = 2
        viewNoCurrentPkg.layer.borderColor = #colorLiteral(red: 1, green: 0.7244103551, blue: 0.2923497558, alpha: 1)
        getUserPackages()
        getPackeges()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionViewUserPackages{
            
            return userPackages.count
            
        }else if collectionView == collectionViewPackages{
            
            return packages.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize.init(width: collectionView.frame.size.width - 24, height: collectionView.frame.size.height - 8)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PackageView", for: indexPath) as! PackageView
        cell.subscribeHandler = self.subscribeBtnHandler(selectedPackageIndex:)
        cell.myIndex = indexPath.row
        if collectionView == collectionViewUserPackages{
            
            cell.lblPgkName.text = "Package"
            cell.lblPkgTitle.text = userPackages[indexPath.row].packageField.name
            if userPackages[indexPath.row].packageField.all {
                
                cell.lblPkgCategories.text = "All Books"
                cell.lblPkgUnits.text = "All Booklets"
                cell.lblPkgSections.text = "All Sheets"
            }else{
                
                cell.lblPkgCategories.text = "\(userPackages[indexPath.row].unlocked.count) Booklets"
                for unit in userPackages[indexPath.row].unlocked{
                    
                    if unit.all{
                        cell.lblPkgSections.text = "All Booklets"
                    }
                }
            }
            cell.btnSubscribe.isHidden = true

            
        }else if collectionView == collectionViewPackages{
            
            cell.lblPgkName.text = packages[indexPath.row].name
            cell.lblPkgTitle.text = ""
            if packages[indexPath.row].all {
                
                cell.lblPkgCategories.text = "All Books"
                cell.lblPkgUnits.text = "All Booklets"
                cell.lblPkgSections.text = "All Sheets"
            }else{
                
                cell.lblPkgCategories.text = "\(packages[indexPath.row].unlocked.count) Books"
                for unit in packages[indexPath.row].unlocked{
                    
                    if unit.all{
                        cell.lblPkgUnits.text = "All Booklets"
                        cell.lblPkgSections.text = "All Sheets"
                        break
                    }
                }
            }
            cell.btnSubscribe.isHidden = false
        }
        return cell
    }
    
    func getUserPackages(){
        
        self.viewNoCurrentPkg.isHidden = true
        showLoaderForCustomView(view: self.viewUserPkgs, color: ColorMainBlue)
        let sm = SubscribtionModel()
        sm.getUserPackages(complation: { (json, statusCode) in
            
            hideLoaderFor(view: self.viewUserPkgs)
            
            if let code = statusCode as? Int{
                
                if code == 200{
                    
                    if json.count > 0{
                        
                        self.viewNoCurrentPkg.isHidden = true
                        self.userPackages = json
                        self.collectionViewUserPackages.reloadData()
                    }
                    else {
                        
                        self.viewNoCurrentPkg.isHidden = false
                    }
                }else {
                    
                    self.viewNoCurrentPkg.isHidden = false
                }
            }
            
        }) { (error, msg) in
            
            self.viewNoCurrentPkg.isHidden = false
            hideLoaderFor(view: self.viewUserPkgs)
            showAlert(title: "", message: "Failed to get current packages.\n Please check your internet connection", vc: self, closure: nil)
        }
    
    }

    
    func getPackeges(){
        
        self.lblNoResultsPackages.isHidden = true
        showLoaderForCustomView(view: self.viewPkgs, color: ColorMainBlue)
        let sm = SubscribtionModel()
        sm.getPackages(complation: { (json, statusCode) in
            
            hideLoaderFor(view: self.viewPkgs)
            
            if let code = statusCode as? Int{
                
                if code == 200{
                    
                    if json.count > 0{
                        
                        self.lblNoResultsPackages.isHidden = true
                        self.packages = json
                        self.collectionViewPackages.reloadData()
                    }
                    else {
                        
                        self.lblNoResultsPackages.isHidden = false
                    }
                }else {
                    
                    self.lblNoResultsPackages.isHidden = false
                }
            }
            
        }) { (error, msg) in
            
            self.lblNoResultsPackages.isHidden = false
            hideLoaderFor(view: self.viewPkgs)
            showAlert(title: "", message: "Failed to get packages.\n Please check your internet connection", vc: self, closure: nil)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PackageSegue"{
            
            if let des = segue.destination as? PackageViewController{
                
                if selectedPackageIndex != nil {
                    des.package = packages[selectedPackageIndex!]
                }
            }
        }
    }

    @objc func subscribeBtnHandler (selectedPackageIndex : Int){
        
        self.selectedPackageIndex = selectedPackageIndex
        performSegue(withIdentifier: "PackageSegue", sender: self)
    }
}
