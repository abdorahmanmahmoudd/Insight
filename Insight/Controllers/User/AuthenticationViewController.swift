//
//  AuthenticationViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 1/29/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class AuthenticationViewController: ParentViewController {

    @IBOutlet var containerView: UIView!
    @IBOutlet var viewBtnSignUpUnderLine: UIView!
    @IBOutlet var viewBtnSignInUnderLine: UIView!
    
    var isKeyboard = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initSignInView()
        configuration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configuration(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if !isKeyboard {
                self.view.frame.size.height -= keyboardSize.height
                isKeyboard = !isKeyboard
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if isKeyboard{
                self.view.frame.size.height += keyboardSize.height
                isKeyboard = !isKeyboard
            }
        }
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func btnSignInClicked(_ sender: UIButton) {
        
        initSignInView()
    }
    
    @IBAction func btnSignUpClicked(_ sender: UIButton) {
        
        initSignUpView()
    }
    

    func initSignInView(){
        
        viewBtnSignInUnderLine.backgroundColor = UIColor.white
        viewBtnSignUpUnderLine.backgroundColor = UIColor.clear
        
        // to reload data without adding posts view over each other
        for view in containerView.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Authentication", bundle: Bundle.main)
        if let SignInView  = storyboard.instantiateViewController(withIdentifier: "SignInVC") as? SignInViewController {
            
            SignInView.view.translatesAutoresizingMaskIntoConstraints = false
            
            SignInView.willMove(toParentViewController: self)
            
            self.containerView.addSubview(SignInView.view)
            
            SignInView.view.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
            
            SignInView.view.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
            
            SignInView.view.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
            
            SignInView.view.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
            self.addChildViewController(SignInView)
            
            SignInView.didMove(toParentViewController: self)
        }
    }
    
    func initSignUpView(){
        
        viewBtnSignUpUnderLine.backgroundColor = UIColor.white
        viewBtnSignInUnderLine.backgroundColor = UIColor.clear
        
        // to reload data without adding posts view over each other
        for view in containerView.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Authentication", bundle: Bundle.main)
        if let SignUpView  = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpViewController {
            
            SignUpView.delegate = self
            
            SignUpView.view.translatesAutoresizingMaskIntoConstraints = false
            
            SignUpView.willMove(toParentViewController: self)
            
            self.containerView.addSubview(SignUpView.view)
            
            SignUpView.view.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
            
            SignUpView.view.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
            
            SignUpView.view.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
            
            SignUpView.view.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
            self.addChildViewController(SignUpView)
            
            SignUpView.didMove(toParentViewController: self)
        }
    }
}
