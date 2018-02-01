//
//  HomeViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 1/31/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var viewsHome: [UIView]!
    var insightContent = [InsightContentRootClass]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setStyle()
        configuration()
        loadContentFile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndex = 0
    }
    
    func setStyle(){
        self.title = "Home"
    }
    
    func configuration(){
        
        SideMenuManager.shared.wire(to: self.navigationController!)
        configureSideMenuBtn()
    }

    func configureSideMenuBtn(){
        
        let btn = UIButton.init(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "icDrawer"), for: .normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(self.openSideMenu), for: .touchUpInside)
        let barBtn = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = barBtn
    }
    
    @objc func openSideMenu(){
        
        SideMenuManager.shared.show(from: self.navigationController!)
    }
    
    func fetchContentFile(){
        
        if let url = URL.init(string: contentJsonURL){
            
            showLoaderFor(view: self.view)
        
            URLSession.shared.dataTask(with: url, completionHandler: { (data, urlResponse, error) in
                
                if let data = data{
                    
                    if let _ = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [Any]{
                        
                        self.saveContentFile(jsonData : data)
                        
                    }
                    
                }
                
                OperationQueue.main.addOperation {
                    hideLoaderFor(view: self.view)
                }
                
            }).resume()
        }
        
    }
    
    func loadContentFile(){
        
        showLoaderFor(view: self.view)
        
        if let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            
            let documentsURL = URL(fileURLWithPath: documentsDirectory)
            
            //            let fileManager = FileManager()
            
            //            if fileManager.fileExists(atPath: documentsURL.absoluteString){
            
            //load file
            
            let filePath = documentsURL.appendingPathComponent(jsonContentFileDirectory)
            
            do {
                
                if let fileData = try? Data.init(contentsOf: filePath, options: .mappedIfSafe){
                    
                    let json = try JSONSerialization.jsonObject(with: fileData, options: .mutableContainers)
                    
                    for item in json as! [Any]{
                        
                        if let i = item as? [String: Any]{
                    
                            self.insightContent.append(InsightContentRootClass.init(fromDictionary: i))
                        }
                    
                    }
                    
                    self.enableViewsInteraction()
                    
                }else {
                    
                    //fetch file then save it
                    fetchContentFile()
                }
                
            }catch let err {
                
                showAlert(title: "", message: err.localizedDescription, vc: self, closure: nil)
            }
            
        }
        hideLoaderFor(view: self.view)
    }
    
    func saveContentFile(jsonData : Data){
        
        
        if let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            
            let documentsURL = URL.init(fileURLWithPath: documentsDirectory)
            
            let savingPath = documentsURL.appendingPathComponent(jsonContentFileDirectory)
            
            do {
                
                try jsonData.write(to: savingPath)
                
                let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                
                for item in json as! [Any]{
                    
                    if let i = item as? [String: Any]{
                        
                        self.insightContent.append(InsightContentRootClass.init(fromDictionary: i))
                    }
                    
                }
                
                self.enableViewsInteraction()
                
            }catch let err{
                
                OperationQueue.main.addOperation {
                    showAlert(title: "", message: err.localizedDescription, vc: self, closure: nil)
                }
            }
            
//            let fm = FileManager.init()
            
//            if fm.fileExists(atPath: savingPath.absoluteString){
//
//                print("File Saved!")
//            }else {
//
//                print("File Not Saved :(")
//            }
        }
    }
    
    func enableViewsInteraction(){
        
        for view in viewsHome{
            
            view.isUserInteractionEnabled = true
        }
    }
    @IBAction func btnItemClicked(_ sender: UIButton) {
        
        print(sender.tag)
        performSegue(withIdentifier: "SubCategorySegue", sender: sender)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SubCategorySegue"{
            
            if let des = segue.destination as? SubCategoryViewController{
                
                des.subCategory = insightContent[((sender as? UIButton)?.tag)! - 1 ].subCategory
                let title = Categories(rawValue: ((sender as? UIButton)?.tag)!)?.desc ?? ""
                des.titleText = title
            }
        }
    }
}
