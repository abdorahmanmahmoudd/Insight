//
//  HomeViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 1/31/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class HomeViewController: ParentViewController {
    
    @IBOutlet var viewsHome: [UIView]!
    var insightContent = [InsightContentRootClass]()
    var flagFilter: Flag?
    var homeTitle = "Home"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    func configuration(){
        
        SideMenuManager.shared.wire(to: self.navigationController!)
        if flagFilter == nil{
            
            addSideMenuBtn()

        }else {
            
            homeTitle = flagFilter?.string ?? "Home"
        }
        self.title = homeTitle

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
                des.flagFilter = self.flagFilter
                des.homeItemId = insightContent[((sender as? UIButton)?.tag)! - 1 ].id
            }
        }
    }
    
    func decode(data: String){
        
        
//        public static String decrypt(String data) {
//            try {
//
//            String[] parts = data.split(":");
//
//            IvParameterSpec iv = new IvParameterSpec(Base64.decode(parts[1], Base64.DEFAULT));
//            SecretKeySpec skeySpec = new SecretKeySpec(ENCRYPTION_KEY.getBytes("UTF-8"), "AES");
//
//            Cipher cipher = Cipher.getInstance(CIPHER_NAME);
//            cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
//
//            byte[] decodedEncryptedData = Base64.decode(parts[0], Base64.DEFAULT);
//
//            byte[] original = cipher.doFinal(decodedEncryptedData);
//
//            return new String(original);
//            } catch (Exception ex) {
//            ex.printStackTrace();
//            }
//
//            return "";
//        }
        do {
            
            var parts = data.split(separator: ":")
            
            
            
        }catch let err {
            
            print(err.localizedDescription)
        }
        
    }
    
//    public static SecretKey secretKey ;
//    static String PLAIN_TEXT = "Java Code Geeks Rock!\0\0\0\0\0\0\0\0\0\0\0";
//    
//    
//    
//    private static String CIPHER_NAME = "AES/CBC/PKCS5PADDING";
//    private static int CIPHER_KEY_LEN = 16; //128 bits
//    
//    static String ENCRYPTION_KEY = "0123456789abcdef";
//    
//    public static void generateKey()  {
//    try {
//    byte[] key = ENCRYPTION_KEY.getBytes();
//    secretKey = new SecretKeySpec(key, "AES");
//    }catch (Exception e){
//    e.printStackTrace();
//    }
//    
//    }
}
