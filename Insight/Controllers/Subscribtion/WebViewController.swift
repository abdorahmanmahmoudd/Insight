//
//  WebViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 4/22/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class WebViewController: ParentViewController {

    @IBOutlet var webView: UIWebView!
    
    var url : URL? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let url = url {
            
            var request = URLRequest.init(url: url)
            request.httpMethod = "get"
            request.setValue("Bearer \(UserModel.getInstance.getUser()?.token ?? "")", forHTTPHeaderField: "Authorization")
            request.setValue(appVersion, forHTTPHeaderField: "version")
            request.setValue("ios", forHTTPHeaderField: "platform")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            webView.loadRequest(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
