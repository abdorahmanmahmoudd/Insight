//
//  SubscribeViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/4/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class SubscribeViewController: ParentViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var lblNoResultsPackages: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var viewContainerCurrentPkg: UIView!
    var packages = [PackageRootClass]()
    
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
        
        self.title = "Subscribe"
        addSideMenuBtn()
        collectionView.register(UINib.init(nibName: "Package", bundle: Bundle.main), forCellWithReuseIdentifier: "PackageView")
        
        getCurrentPackage()
        getPackeges()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize.init(width: collectionView.frame.size.width - 8, height: collectionView.frame.size.height - 8)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PackageView", for: indexPath) as! PackageView
        
        cell.lblPgkName.text = packages[indexPath.row].name
        cell.lblPkgTitle.text = packages[indexPath.row].name
        cell.lblPkgMonths.text = packages[indexPath.row].name
        cell.lblPkgQuestions.text = packages[indexPath.row].name
        cell.lblPkgUnits.text = packages[indexPath.row].name
        return cell
    }
    
    func getCurrentPackage(){
        
        if let vc = Bundle.main.loadNibNamed("Package", owner: nil, options: nil)?.first as? PackageView {
            
            vc.btnSubscribe.isHidden = true
            vc.willMove(toSuperview: self.viewContainerCurrentPkg)
            vc.translatesAutoresizingMaskIntoConstraints = false
            self.viewContainerCurrentPkg.addSubview(vc)
            vc.leadingAnchor.constraint(equalTo: self.viewContainerCurrentPkg.leadingAnchor).isActive = true
            vc.trailingAnchor.constraint(equalTo: self.viewContainerCurrentPkg.trailingAnchor).isActive = true
            vc.topAnchor.constraint(equalTo: self.viewContainerCurrentPkg.topAnchor).isActive = true
            vc.bottomAnchor.constraint(equalTo: self.viewContainerCurrentPkg.bottomAnchor).isActive = true
            vc.didMoveToSuperview()
            
        }
    
    }

    
    func getPackeges(){
        
        self.lblNoResultsPackages.isHidden = true
        showLoaderFor(view: self.view)
        let sm = SubscribtionModel()
        sm.getPackages(complation: { (json, statusCode) in
            
            hideLoaderFor(view: self.view)
            
            if let code = statusCode as? Int{
                
                if code == 200{
                    
                    if json.count > 0{
                        
                        self.lblNoResultsPackages.isHidden = true
                        self.packages = json
                        self.collectionView.reloadData()
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
            hideLoaderFor(view: self.view)
            showAlert(title: "", message: "Failed to get packages.\n Please check your internet connection", vc: self, closure: nil)
        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
