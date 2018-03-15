//
//  UserAccountViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/19/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class UserAccountViewController: ParentViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var constraintHeightOfPickerView: NSLayoutConstraint!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var btnChangePassword: UIButton!
    @IBOutlet var tfGovernorate: UITextField!
    @IBOutlet var tfSchool: UITextField!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPhone: UITextField!
    @IBOutlet var tfName: UITextField!
    
    var isKeyboard = false
    
    var governorates = ["Alexandria", "Aswan", "Asyut", "Beheira", "Beni Suef", "Cairo", "Dakahlia", "Damietta", "Faiyum", "Gharbia", "Giza", "Ismailia", "Kafr El Sheikh", "Luxor", "Matruh", "Minya", "Monufia", "New Valley", "North Sinai", "Port Said", "Qalyubia", "Qena", "Red Sea", "Sharqia", "Sohag", "South Sinai", "Suez"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setStyle()
        configuration()
        fillData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndex = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuration(){
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            if !isKeyboard {
//                self.view.frame.size.height -= keyboardSize.height
//                isKeyboard = !isKeyboard
//            }
//        }
//    }
//    
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            if isKeyboard{
//                self.view.frame.size.height += keyboardSize.height
//                isKeyboard = !isKeyboard
//            }
//        }
//    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return governorates.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return governorates[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfGovernorate.text = governorates[row]
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setStyle(){
    
        self.title = "Account"
        self.addSideMenuBtn()
    }
    
    func fillData(){
        
        if let user = UserModel.getInstance.getUser(){
            
            tfName.text = user.user.name
            tfPhone.text = user.user.mobile
            tfEmail.text = user.user.email
            tfGovernorate.text = user.user.governorate
            tfSchool.text = user.user.school
        }
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        
        if dataIsValid(){
            
            save()
        }
        
    }
    @IBAction func btnChangePasswordClicked(_ sender: UIButton) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as? ChangePasswordViewController{
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func dataIsValid() -> Bool{
        
        var isValid = true
        
        if tfName.text != nil && tfName.text!.hasNoCharchters(){
            
            isValid = false
            showAlert(title: "", message: "Please enter your name", vc: self, closure: nil)
            
        }else if tfPhone.text != nil && tfPhone.text!.hasNoCharchters() {
            
            isValid = false
            showAlert(title: "", message: "Please enter phone number", vc: self, closure: nil)
            
        }else if !tfPhone.text!.isValidPhone() {
            
            isValid = false
            showAlert(title: "", message: "Phone number must be 11 digits", vc: self, closure: nil)
            
        }else if tfGovernorate.text != nil && tfGovernorate.text!.hasNoCharchters() {
            
            isValid = false
            showAlert(title: "", message: "Please enter your governorate", vc: self, closure: nil)
            
        }else if tfEmail.text != nil && tfEmail.text!.hasNoCharchters(){
            
            isValid = false
            showAlert(title: "", message: "Please enter your Email", vc: self, closure: nil)
            
        }else if !tfEmail.text!.isValidEmail(){
            
            isValid = false
            showAlert(title: "", message: "Invalid Email address", vc: self, closure: nil)
        }
        
        
        return isValid
    }
    
    func save(){
        btnSave.isEnabled = false
        btnChangePassword.isEnabled = false
        showLoaderFor(view: self.view)
        
        let um = UserModel()
        um.editProfile(name: tfName.text!, phone: tfPhone.text!, govern: tfGovernorate.text!, email: tfEmail.text!, school: tfSchool.text ?? "", complation: { (json, code) in
            
            hideLoaderFor(view: self.view)
            self.btnSave.isEnabled = true
            self.btnChangePassword.isEnabled = true
            
            if let statusCode = code as? Int {
                
                if statusCode == 200 {
                    
                    if let obj = json{
                        
                        if obj.isSuccess {
                            
                            showAlert(title: "", message: "Profile edited successfully", vc: self, closure: {
                                
                                if let oldUser = UserModel.getInstance.getUser(){
                                    
                                    oldUser.user.name = self.tfName.text
                                    oldUser.user.email = self.tfEmail.text
                                    oldUser.user.governorate = self.tfGovernorate.text
                                    oldUser.user.school = self.tfSchool.text
                                    oldUser.user.mobile = self.tfPhone.text
                                    
                                    UserModel.getInstance.saveUser(oldUser)
                                }
                            })
                        }else {
                            
                            showAlert(title: "", message: obj.message, vc: self, closure: nil)
                        }
                    }
                    
                    
                }else if statusCode == 452 {//token expired
                    
                    // TODO: call refresh token API
                    showAlert(title: "", message: "Token expired", vc: self, closure: nil)
                    
                }else if statusCode == 456{
                    
                    showAlert(title: "", message: "User account is blocked", vc: self, closure: nil)
                    
                }else if statusCode == 451{ //force update
                    
                    // TODO: update the app
                    showAlert(title: "", message: "Update the application", vc: self, closure: nil)
                    
                }else if statusCode == 400{ //taken mobile or email
                    
                    showAlert(title: "", message: "Number or Email already exists", vc: self, closure: nil)
                    
                }else {
                    
                    showAlert(title: "", message: "Error code \(statusCode)", vc: self, closure: nil)
                }
                
            }
            
            
        }) { (error, msg) in
            
            self.btnSave.isEnabled = true
            self.btnChangePassword.isEnabled = true
            hideLoaderFor(view: self.view)
            showAlert(title: "", message: "Check your internet connection", vc: self, closure: nil)
            
        }
    }
    
    @IBAction func btnOpenPickerClicked(_ sender: UIButton) {
        
        if constraintHeightOfPickerView.constant == 0 {
            
            constraintHeightOfPickerView.constant = 162
        }else{
            
           constraintHeightOfPickerView.constant = 0
        }
    }
    
}
