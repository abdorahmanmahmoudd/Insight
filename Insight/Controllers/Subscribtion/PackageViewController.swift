//
//  PackageViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/4/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit
import SafariServices

enum subType: String{
    
    case duration = "duration_package_id"
    case promo = "promocode_id"
}

class PackageViewController: ParentViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    @IBOutlet var btnSubscribe: UIButton!
    @IBOutlet var viewPkgPrice: UIView!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblPackageName: UILabel!
    @IBOutlet var collectionViewDurtions: UICollectionView!
    @IBOutlet var tvDescription: UITextView!
    @IBOutlet var imgCodeVerification: UIImageView!
    @IBOutlet var tfPromoCode: UITextField!
    
    var package : PackageRootClass?
    var durations = [PackagesDuration]()
    var searchTimer : Timer?
    var selectedDurationIndex = Int()
    var validPromoCode = false
    var promoCodeId = Int()
    var discountRatio = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnSubscribeClicked(_ sender: UIButton) {
     
        
        if validPromoCode {
            
            createPackage(id: String(promoCodeId), type: subType.promo.rawValue)
            
        }else{
            createPackage(id: String(durations[selectedDurationIndex].id), type: subType.duration.rawValue)
        }
    }
    
    func configuration(){
        
        self.title = package?.name
        viewPkgPrice.layer.borderWidth = 2
        viewPkgPrice.layer.borderColor = #colorLiteral(red: 1, green: 0.7244103551, blue: 0.2923497558, alpha: 1)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        fillData()
        
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func fillData(){
        
        if let pkg = package{
            
            if pkg.unlocked.count == 0{
                self.tvDescription.text = ""
            }else{
                var descriptionTxt = "Unlocks "
                for item in pkg.unlocked{
                    
                    descriptionTxt += " \(item.categoryName ?? "-"),"
                }
                descriptionTxt.removeLast(1)
                self.tvDescription.text = descriptionTxt
            }
            
            for duration in pkg.packagesDurations{
                
                self.durations.append(duration)
            }
            
            if self.durations.count == 0{
                self.btnSubscribe.isEnabled = false
            }else{
                collectionViewDurtions.selectItem(at: IndexPath.init(row: 0, section: 0), animated: false, scrollPosition:.left)
            }
            
            self.collectionViewDurtions.reloadData()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return durations.count
    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize.init(width: "\(durations[indexPath.row].duration) Months".width(withConstraintedHeight: 0, font: getFont(17, MavenProMedium)), height: collectionViewLayout.collectionViewContentSize.height)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "durationCell", for: indexPath) as! DurationCollectionViewCell
        
        if durations[indexPath.row].duration < 2 {
            cell.lblTitle.text = "\(durations[indexPath.row].duration ?? 0) Month"
        }else{
            cell.lblTitle.text = "\(durations[indexPath.row].duration ?? 0) Months"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //handle selection
        
        if validPromoCode{
            
            let finalPrice = (discountRatio / 100) * (durations[indexPath.row].price ?? 0)
            self.lblPrice.text = "\(finalPrice)"
        }else{
            
            lblPrice.text = "\(durations[indexPath.row].price - ((durations[indexPath.row].discount / 100) * durations[indexPath.row].price))"
        }
        selectedDurationIndex = indexPath.row
//        self.validPromoCode = false
    }
    
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if searchTimer != nil{
            searchTimer?.invalidate()
            searchTimer = nil
        }
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
            
            if !textField.text!.hasNoCharchters() {
               
                self.validateCode(code: textField.text!)
            }
        })
        
        return true
    }
    
    func validateCode(code: String){
        
        self.imgCodeVerification.image = UIImage()
        showLoaderInsideButton(view: imgCodeVerification, color: UIColor.gray)
        btnSubscribe.isEnabled = false
        let sm = SubscribtionModel()
        sm.validateCode(code: code, complation: { (json, code) in
            
            hideLoaderFor(view: self.imgCodeVerification)
            self.btnSubscribe.isEnabled = true
            
            if let statusCode = code as? Int{
                
                if statusCode == 200{
                    
                    if json.isValid {
                        self.validPromoCode = true
                        self.promoCodeId = json.promocode.id
                        self.imgCodeVerification.image = #imageLiteral(resourceName: "CORRECT")
                        self.discountRatio = json.promocode.discount
                        let finalPrice = (json.promocode.discount / 100) * (self.durations[self.selectedDurationIndex].price ?? 0)
                        self.lblPrice.text = "\(finalPrice)"
                        
                    }else{
                        self.validPromoCode = false
                        self.imgCodeVerification.image = #imageLiteral(resourceName: "ic_wrong")
//                        showAlert(title: "", message: json.msg, vc: self, closure: nil)
                    }
                    
                }else{
                    self.validPromoCode = false
                    self.imgCodeVerification.image = #imageLiteral(resourceName: "ic_wrong")
                    showAlert(title: "", message: json.msg ?? "Something went wrong!", vc: self, closure: nil)
                }
            }
            
        }) { (error, msg) in
            
            self.validPromoCode = false
            self.btnSubscribe.isEnabled = true
            hideLoaderFor(view: self.imgCodeVerification)
            self.imgCodeVerification.image = #imageLiteral(resourceName: "ic_wrong")
            showAlert(title: "", message: "Failed to check the code\n Please check your internet connection", vc: self, closure: nil)
        }
    }
    
    func createPackage(id :String, type: String){
        
        showLoaderFor(view: self.view)
        btnSubscribe.isEnabled = false
        let sm = SubscribtionModel()
        sm.CreateUserPackage(type: type, id: id, complation: { (json, code) in
            
            hideLoaderFor(view: self.view)
            self.btnSubscribe.isEnabled = true
            
            if let statusCode = code as? Int{
                
                if statusCode == 200 {
                    
                    if json.isSuccess{
                        
                        showAlert(title: "", message: "Package created successfully", vc: self, closure: {
                            
                            let fawry = "\(fawryURL)?mobile=\(json.packageField.mobile!)&email=\(json.packageField.email!)&price=\(json.packageField.price!)&orderId=\(json.packageField.orderId!)&packageName=\(json.packageField.packageName!)"
                            
                            if let url = URL(string: fawry ){
                                
                                let svc = SFSafariViewController(url: url)
                                svc.preferredBarTintColor = ColorMainBlue
                                svc.preferredControlTintColor = .white
                                if #available(iOS 11.0, *) {
                                    svc.dismissButtonStyle = .close
                                }
                                self.present(svc, animated: true, completion: nil)
                                
                            }
                        })
                    }else{
                        
                        showAlert(title: "", message: json.message ?? "Something went wrong", vc: self, closure: nil)
                    }
                }else{
                    showAlert(title: "", message: json.message ?? "Something went wrong", vc: self, closure: nil)
                }
            }
            
            
        }) { (error, msg) in
            
            self.btnSubscribe.isEnabled = true
            hideLoaderFor(view: self.view)
            showAlert(title: "", message: "Failed to subscribe\n Please check your internet connection", vc: self, closure: nil)
        }
        
    }

}
