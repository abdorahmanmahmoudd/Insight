//
//  HomeViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 1/31/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit
import CryptoSwift


class HomeViewController: ParentViewController {
    
    @IBOutlet var viewsHome: [UIView]!
    var insightContent = [InsightContentRootClass]()
    var flagFilter: Flag?
    var homeTitle = "Home"
//    var cameFromFlag = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
        checkFileSize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndex = 0
        
//        if cameFromFlag {
//
//            selectedIndex = 3
//        }
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

    func checkFileSize(){
        
        //get file size
        var callSuccessed = false
        showLoaderFor(view: self.view)
        let sm = ServerManager()
        sm.httpConnect(with: FileSizeURL, method: .get, paramters: nil, authentication: UserModel.getInstance.getUser()?.token ?? "", complation: { (json, code) in
            
            hideLoaderFor(view: self.view)
            if let statusCode = code as? Int{
                
                if statusCode == 200 {
                    
                    if let obj = json as? [String : Any]{
                        
                        if let onlineSize = obj["filesize"] as? Int{
                            
                            callSuccessed = true
                            let localSize = UserDefaults.standard.integer(forKey: InsightFileSizeKey)
                            if localSize == 0 {
                                // file does not exists
                                UserDefaults.standard.set(onlineSize, forKey: InsightFileSizeKey)
                                self.fetchContentFile()

                            }else  {
                                
                                if localSize == onlineSize{
                                    //load exists file
                                    self.loadContentFile()
                                }else{
                                    //update the file
                                    UserDefaults.standard.set(onlineSize, forKey: InsightFileSizeKey)
                                    self.fetchContentFile()
                                }
                            }
                        }
                    }
                }
            }
            if !callSuccessed{
                print("call not successeded: will try to fetch local file")
                self.loadContentFile()
            }
            
            
        }) { (error, msg) in
            
            hideLoaderFor(view: self.view)
            print("Something went wrong, Please check your internet connection")
            
        }
    
    }
    
    
    func fetchContentFile(){
        
        if let url = URL.init(string: contentJsonURL){
            
            showLoaderFor(view: self.view)
        
            URLSession.shared.dataTask(with: url, completionHandler: { (data, urlResponse, error) in
                
                if let data = data{
                    
                    if let _ = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [Any]{
                        
                        DispatchQueue.main.async {
                            self.saveContentFile(jsonData:  data)
                        }
                        
                    }
                    
                    //decode
                    //                    let dataString = String.init(data: data, encoding: .utf8)
                    //                    if let decodedStr = self.decode(data: dataString!){
                    //                        if let jsonData = try? JSONSerialization.data(withJSONObject: decodedStr, options:[]){
                    //
                    //                            if let jsonStr = String.init(data: jsonData, encoding: String.Encoding.utf8){
                    //
                    //                                self.saveContentFile(jsonData:  jsonData)
                    //
                    //                            }
                    //                        }
                    //                    }
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
    
    func saveContentFile(jsonData: Data){
        
        
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
                des.homeItemId = insightContent[((sender as? UIButton)?.tag)! - 1 ].id
                
                if let flag = self.flagFilter{
                    des.flagFilter = flag
                    
                    do {
                        
                        let flaggedQuestions = realm?.objects(FlaggedQuestion.self)
                        
                        des.subCategory = des.subCategory.filter({ (subCategory) -> Bool in
                            
                            if let questionsParentParentIDs = flaggedQuestions?.map ({ $0.parentParentId }) {
                                
                                return questionsParentParentIDs.contains(String(subCategory.id))
                            }
                            return false
                        })
                        
//                        des.subCategory = des.subCategory.filter({ (subCategory) -> Bool in
//
//                            return subCategory.subSubCategory.filter({ (subsub) -> Bool in
//
//                                var filteredQuestions = [QuestionData]()
//
//                                if let questionsIDs = flaggedQuestions?.map ({ $0.Id }) {
//
//                                    for i in 0..<subsub.questions.count{
//
//                                        filteredQuestions = subsub.questions[i].data.filter({ (question) -> Bool in
//                                            return questionsIDs.contains(String(question.id))
//                                        })
//                                    }
//                                }
//
//                                return filteredQuestions.count > 0 ? true : false
//
//                            }).count > 0 ? true : false
//                        })
                        
                    }catch let err {
                        
                        showAlert(title: "", message: err.localizedDescription, vc: self, closure: nil)
                    }
                    
                }
            }
        }
    }
    
    
    
    func decode(data: String) -> String?{
        
        
        //    public static SecretKey secretKey ;
        //    private static String CIPHER_NAME = "AES/CBC/PKCS5PADDING";
        //    static String ENCRYPTION_KEY = "0123456789abcdef";
//
//            IvParameterSpec iv = new IvParameterSpec(Base64.decode(parts[1], Base64.DEFAULT));
//            SecretKeySpec skeySpec = new SecretKeySpec(ENCRYPTION_KEY.getBytes("UTF-8"), "AES");
//
//            Cipher cipher = Cipher.getInstance(CIPHER_NAME);
//            cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
//            byte[] decodedEncryptedData = Base64.decode(parts[0], Base64.DEFAULT);
//            byte[] original = cipher.doFinal(decodedEncryptedData);

        do {
            
//            let CIPHER_NAME = "AES/CBC/PKCS5PADDING"
            let ENCRYPTION_KEY = "0123456789abcdef"
            var parts = data.split(separator: ":")
            
            let input = String(parts[0])
            var iv = String(parts[1])
//            print(part0)
            iv.removeLast(1)
            iv = iv.base64Decoded()
            
            let dec = try AES(key: Array(ENCRYPTION_KEY.utf8), blockMode: .CBC(iv: Array(iv.utf8))).decrypt(Array(input.utf8))
            
            let decData = Data(bytes: dec)
            
            if let inputData = NSData.init(base64Encoded: input, options: .init(rawValue: 0)) as Data?{
                
                if let inputBase64 = String.init(data: inputData, encoding: .utf8){
                    
                    print(inputBase64)
                    
                    let aes = try AES.init(key: ENCRYPTION_KEY, iv: iv)
                    
                    let decryptResult = try aes.decrypt(inputBase64.bytes)
                    
                    let decryptedData = Data.init(bytes: decryptResult)
                    
                    let decrytedStr = String.init(data: decryptedData, encoding: String.Encoding.utf8)
                    
                    print("\(decrytedStr)")
                    
                    return decrytedStr
                }
                //            let aes = try AES.init(key: ENCRYPTION_KEY.bytes, blockMode: BlockMode.CBC(iv: iv.bytes), padding: Padding.pkcs5)
                //            let decryptResult = try AES.init(key: ENCRYPTION_KEY, iv: iv, padding: .pkcs5).decrypt(decryptBytes)

            }
            
            
        }catch let err {
            
            print(err.localizedDescription)
            return nil
        }
        
        return nil
        
    }

}
