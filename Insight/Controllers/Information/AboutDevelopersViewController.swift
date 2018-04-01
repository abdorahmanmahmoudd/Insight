//
//  AboutDevelopersViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/8/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class AboutDevelopersViewController: ParentViewController , MFMailComposeViewControllerDelegate{

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
        
        selectedIndex = 7
        self.title = "About Developers"
        addSideMenuBtn()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnEmailClicked(_ sender: UIButton) {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["info@clueapps.net"])
            present(mail, animated: true)
        }
        
    }
    @IBAction func btnWebsiteClicked(_ sender: UIButton) {

        if let url = URL(string: "https://clueapps.net/" ){
            
            let svc = SFSafariViewController(url: url)
            svc.preferredBarTintColor = ColorMainBlue
            svc.preferredControlTintColor = .white
            if #available(iOS 11.0, *) {
                svc.dismissButtonStyle = .close
            }
            self.present(svc, animated: true, completion: nil)
        }

    }
    @IBAction func btnLinkedInClicked(_ sender: UIButton) {
        
        if let url = URL(string: "https://www.linkedin.com/company/10674034/" ){
            
            let svc = SFSafariViewController(url: url)
            svc.preferredBarTintColor = ColorMainBlue
            svc.preferredControlTintColor = .white
            if #available(iOS 11.0, *) {
                svc.dismissButtonStyle = .close
            }
            self.present(svc, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnFbClicked(_ sender: UIButton) {

        if let url = URL(string: "https://www.facebook.com/clueapps" ){
            
            let svc = SFSafariViewController(url: url)
            svc.preferredBarTintColor = ColorMainBlue
            svc.preferredControlTintColor = .white
            if #available(iOS 11.0, *) {
                svc.dismissButtonStyle = .close
            }
            self.present(svc, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
}
