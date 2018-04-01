//
//  HomeViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 1/31/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit
import CryptoSwift


class HomeViewController: ParentViewController, URLSessionTaskDelegate, URLSessionDataDelegate, URLSessionDelegate {
    
    @IBOutlet var viewsHome: [UIView]!
    var insightContent = [InsightContentRootClass]()
    var flagFilter: Flag?
    var homeTitle = "Home"
//    var cameFromFlag = false
    var userPackages = [PackageRootClass]()

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
        
        self.progress.alpha = 0.0

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
    
    
    @IBOutlet weak var progress: UIProgressView!
    
    var buffer:NSMutableData = NSMutableData()
    var session:URLSession?
    var dataTask:URLSessionDataTask?
    var expectedContentLength = 0
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        buffer.append(data)
        let percentageDownloaded = Float(buffer.length) / Float(expectedContentLength)
        progress.progress =  percentageDownloaded
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        //here you can get full lenth of your content
        expectedContentLength = Int(response.expectedContentLength)
        print(expectedContentLength)
        completionHandler(URLSession.ResponseDisposition.allow)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        //use buffer here. Download is done
        progress.progress = 1.0   // download 100% complete
        if let err = error {
            showAlert(title: "Try again", message: err.localizedDescription, vc: self, closure: {
                if let url = URL.init(string: contentJsonURL){
                    
                    self.progress.progress = 0.0
                    self.progress.alpha = 1.0
                    let configuration = URLSessionConfiguration.default
                    let mainqueue = OperationQueue.main
                    self.session = URLSession(configuration: configuration, delegate:self, delegateQueue: mainqueue)
                    self.dataTask = session.dataTask(with: URLRequest.init(url: url))
                    self.dataTask?.resume()
                }
            })
        }else{
            
            self.progress.alpha = 0.0
            
            if let data = self.buffer as? Data{
                
                if let _ = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [Any]{
                    
//                    DispatchQueue.main.async {
                        self.saveContentFile(jsonData:  data)
//                    }
                    
                    //                    var txt = "kqEuUlEx3UA+uc+l27QByQ==:ZmVkY2JhOTg3NjU0MzIxMA=="
                    //decode
                    
                    //                    let dataString = String.init(data: data, encoding: String.Encoding.utf8)
                    //
                    //                    if let decodedStr = self.decode(data: dataString!){
                    //
                    //                        if let jsonData = try? JSONSerialization.data(withJSONObject: decodedStr, options:[]){
                    //
                    //                            if let jsonStr = String.init(data: jsonData, encoding: String.Encoding.utf8){
                    //
                    //                                DispatchQueue.main.async {
                    //                                    self.saveContentFile(jsonData:  data)
                    //                                }
                    //                            }
                    //                        }
                    //                    }
                }
            }
        }
    }
    
    func fetchContentFile(){
        
        if let url = URL.init(string: contentJsonURL){
            
            progress.progress = 0.0
            progress.alpha = 1.0
            let configuration = URLSessionConfiguration.default
            let mainqueue = OperationQueue.main
            session = URLSession(configuration: configuration, delegate:self, delegateQueue: mainqueue)
            dataTask = session?.dataTask(with: URLRequest.init(url: url))
            dataTask?.resume()
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
                    
                    self.getUserPackages()
                    
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
                self.getUserPackages()
                
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
        if userPackages.count > 0{
            performSegue(withIdentifier: "SubCategorySegue", sender: sender)
        }else{
            showYesNoAlert(title: "", message: "Please subscribe to open categories", vc: self, closure: { (yes) in
                if yes{
                    
                    let sb = UIStoryboard.init(name: "Subscribtion", bundle: Bundle.main)
                    let viewController = sb.instantiateViewController(withIdentifier: "SubscribeVC")
                    self.navigationController?.setViewControllers([viewController], animated: true)
                }
            })
        }
        
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
                    
                    if let flaggedQuestions = realm?.objects(FlaggedQuestion.self){
                        
                        des.subCategory = des.subCategory.filter({ (subCategory) -> Bool in
                            
                            let questionsParentParentIDs = flaggedQuestions.map ({ $0.parentParentId })
                            
                            return questionsParentParentIDs.contains(String(subCategory.id))
                            
                        })
                    }
                }
//                else{
//                    // handle unlocked sub categories of the selected category
//
//                    let categoryIds = userPackages.map ({ $0.packageField.id })
//
//                    if let catId = insightContent[view.tag - 1].id{
//
//                        if categoryIds.contains(where: { (id) -> Bool in
//                            return id == catId
//                        }){
//
//                            view.isUserInteractionEnabled = true // enable unlocked categories only
//                        }
//                    }
//
//                }
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
        
//        public static function encrypt($key, $iv, $data) {
//
//            $OPENSSL_CIPHER_NAME = "aes-128-cbc"; //Name of OpenSSL Cipher
//            $CIPHER_KEY_LEN = 16; //128 bits
//
//            if (strlen($key) < $CIPHER_KEY_LEN) {
//                $key = str_pad("$key", $CIPHER_KEY_LEN, "0"); //0 pad to len 16
//            } else if (strlen($key) > $CIPHER_KEY_LEN) {
//                $key = substr($str, 0, $CIPHER_KEY_LEN); //truncate to 16 bytes
//            }
//
//            $encodedEncryptedData = base64_encode(openssl_encrypt($data, $OPENSSL_CIPHER_NAME, $key, OPENSSL_RAW_DATA, $iv));
//            $encodedIV = base64_encode($iv);
//            $encryptedPayload = $encodedEncryptedData.":".$encodedIV;
//
//            return $encryptedPayload;
//
//        }
//
//        /**
//         * Decrypt data using AES Cipher (CBC) with 128 bit key
//         *
//         * @param type $key - key to use should be 16 bytes long (128 bits)
//         * @param type $data - data to be decrypted in base64 encoding with iv attached at the end after a :
//         * @return decrypted data
//         */
//        public static function decrypt($key, $data) {
//
//            $OPENSSL_CIPHER_NAME = "aes-128-cbc"; //Name of OpenSSL Cipher
//            $CIPHER_KEY_LEN = 16; //128 bits
//
//            if (strlen($key) < $CIPHER_KEY_LEN) {
//                $key = str_pad("$key", $CIPHER_KEY_LEN, "0"); //0 pad to len 16
//            } else if (strlen($key) > $CIPHER_KEY_LEN) {
//                $key = substr($str, 0, $CIPHER_KEY_LEN); //truncate to 16 bytes
//            }
//
//            $parts = explode(':', $data); //Separate Encrypted data from iv.
//            $decryptedData = openssl_decrypt(base64_decode($parts[0]), $OPENSSL_CIPHER_NAME, $key, OPENSSL_RAW_DATA, base64_decode($parts[1]));
//
//            return $decryptedData;
//        }

        do {
//            let CIPHER_NAME = "AES/CBC/PKCS5PADDING"
            let ivKey = "fedcba9876543210"
            let ENCRYPTION_KEY = "0123456789abcdef"
            var parts = data.split(separator: ":")
            var input = String(parts[0])
//            var iv = String(parts[1])
//            print(part0)
//            iv.removeLast(1)
//            iv = iv.base64Decoded()
//            input.removeFirst(1)
            
//            let decodedData = NSData(base64Encoded: input, options:NSData.Base64DecodingOptions.init(rawValue: 0))
//            let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue) as? String
//            print(decodedString)
            try testEnc()
            
//            let dex = try AES(key: ENCRYPTION_KEY.bytes, blockMode: BlockMode.CBC(iv: Array(iv.utf8))).decrypt(input.bytes)
            let dec = try AES(key: ENCRYPTION_KEY.bytes, blockMode: .CBC(iv: ivKey.bytes), padding: Padding.pkcs7).encrypt(data.bytes)
            
            let encryptedString = String.init(bytes: dec, encoding: .utf8)
            
            _ = Data(bytes: dec)
            
            if let inputData = NSData.init(base64Encoded: input, options: .init(rawValue: 0)) as Data?{
                
                if let inputBase64 = String.init(data: inputData, encoding: .utf8){
                    
                    print(inputBase64)
                    
                    let aes = try AES.init(key: ENCRYPTION_KEY, iv: ivKey)
                    
                    let decryptResult = try aes.decrypt(inputBase64.bytes)
                    
                    let decryptedData = Data.init(bytes: decryptResult)
                    
                    let decrytedStr = String.init(data: decryptedData, encoding: String.Encoding.utf8)
                    
                    print("\(String(describing: decrytedStr))")
                    
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
    
    func testEnc() throws {
        
        let ivKey = "fedcba9876543210"
        let message = "Test Message"
        let password = "0123456789abcdef"
        
        do {
            let messageArray = Array(message.utf8)
            let encrypted = try AES(key: password.bytes, blockMode: .CBC(iv: Array(ivKey.utf8)), padding: .pkcs5).encrypt(messageArray)
            let encryptedString = String.init(bytes: encrypted, encoding: .utf8)
            let decrypted = try AES(key: password.bytes, blockMode: .CBC(iv: Array(ivKey.utf8)), padding: .pkcs5).decrypt(encrypted)
            let decryptedString = String.init(bytes: decrypted, encoding: .utf8)
            assert(message == decryptedString)
        } catch {
            print(error)
        }
    }
    
    func getUserPackages(){
        
        showLoaderFor(view: self.view)
        let sm = SubscribtionModel()
        sm.getUserPackages(complation: { (json, statusCode) in
            
            hideLoaderFor(view: self.view)
            
            if let code = statusCode as? Int{
                
                if code == 200{
                    
                    if json.count > 0{
                        
                        self.userPackages = json
                        self.upsertUserPackages()
                    }
                    else {
                        self.upsertUserPackages()
                    }
                }else {
                    self.upsertUserPackages()
                }
            }
            
        }) { (error, msg) in
            
            self.enableViewsInteraction()
            hideLoaderFor(view: self.view)
            print("\(String(describing: msg))")
            showAlert(title: "Error", message: "Cannot get user package\n Please check your internet connection", vc: self, closure: nil)
        }
    }
    
    func upsertUserPackages(){
        
        do{
            for package in userPackages{
                
                if package.packageField.all{
                    
                    let pkg = UserPackageItem()
                    pkg.PackageId = package.packageField.id
                    pkg.all = package.packageField.all
                    pkg.expiryDate = package.expiredAt
                    
                    try realm?.write {
                        realm?.add(pkg, update: true)
                    }
                    
                }else{
                    
                    for i in 0..<package.packageField.unlocked.count{
                        
                        let pkg = UserPackageItem()
                        pkg.PackageId = package.packageField.id
                        pkg.categoryId = package.packageField.unlocked[i].categoryId
                        pkg.allSubCategories = package.packageField.unlocked[i].all
                        pkg.expiryDate = package.expiredAt
                        if !package.packageField.unlocked[i].all{
                            
//                            for subsubCategory in package.packageField.unlocked[i].unlockedSubCategory{
//
//                                //unlockedSubCategory is any object so backend needs to changes that if its required.
//                            }
                        }
                        
                        try realm?.write {
                            realm?.add(pkg, update: true)
                        }
                        
                    }
                }
            }
            //delete expired packages
            if let packages = realm?.objects(UserPackageItem.self){
                for package in packages{
                    
                    if TimeInterval(package.expiryDate)  >= Date().timeIntervalSince1970{
                        
                        try realm?.write {
                            realm?.delete(package)
                        }
                    }
                }
            }

            self.enableViewsInteraction()
            
        }catch let err {
            
            showAlert(title: "", message: err.localizedDescription, vc: self, closure: nil)
        }
    }
}
