//
//  SideMenuViewController.swift
//  DHCR
//
//  Created by Fady on 11/26/17.
//  Copyright © 2017 LinkDevelopment. All rights reserved.
//

import UIKit
import RealmSwift

var selectedIndex: Int = 0 //refere to the selected side menu item 

class SideMenuViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
	private var delegate: UINavigationController? {
		return (self.presentingViewController as? UINavigationController)
	}
    
    var MenuItems = ["Home", "Account" , "Subscribe" , "Flagged" , "Note" , "Results", "About App" , "About Developers" , "Share", "Log Out" ]
	
    override func viewDidLoad() {
        super.viewDidLoad()
		reset()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateFlagCounter(_:)), name: NSNotification.Name("UpdateFlagCounter"), object: nil)
    }
    
    @objc func updateFlagCounter(_ notification: NSNotification){
        
        tableView.reloadRows(at: [IndexPath.init(row: 3, section: 0)], with: .none)

    }
	
	func performAnimation() {
        
		self.tableView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: UIScreen.main.bounds.size.height)
        
		self.tableView.alpha = 1
        
		UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseOut, animations: {
			self.tableView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -UIScreen.main.bounds.size.height/16)

		}) { (finished) in
			UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
				self.tableView.transform = CGAffineTransform.identity
			})
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

	}
	
    func getViewController(for index: Int) -> UIViewController {

        var viewController = UIViewController()

        if index == 0{ 

            let sb = UIStoryboard.init(name: "Home", bundle: Bundle.main)
            viewController = sb.instantiateViewController(withIdentifier: "HomeVC")

        }else if index == 1{
            
            let sb = UIStoryboard.init(name: "Account", bundle: Bundle.main)
            viewController = sb.instantiateViewController(withIdentifier: "UserAccountVC")
            
        }else if index == 2{
            
            let sb = UIStoryboard.init(name: "Subscribtion", bundle: Bundle.main)
            viewController = sb.instantiateViewController(withIdentifier: "SubscribeVC")
            
        }else if index == 3{
            
            let sb = UIStoryboard.init(name: "Flag", bundle: Bundle.main)
            viewController = sb.instantiateViewController(withIdentifier: "FlagVC")
            
        }else if index == 4{
            
            let sb = UIStoryboard.init(name: "Note", bundle: Bundle.main)
            viewController = sb.instantiateViewController(withIdentifier: "AppNoteVC")
            
        }else if index == 5{
            
            let sb = UIStoryboard.init(name: "Home", bundle: Bundle.main)
            viewController = sb.instantiateViewController(withIdentifier: "ResultsVC")
        }else if index == 6{
            
            let sb = UIStoryboard.init(name: "Information", bundle: Bundle.main)
            viewController = sb.instantiateViewController(withIdentifier: "AboutAppVC")
        }else if index == 7{
            
            let sb = UIStoryboard.init(name: "Information", bundle: Bundle.main)
            viewController = sb.instantiateViewController(withIdentifier: "AboutDevelopersVC")
        }else if index == 8{
            
            // https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/601958396
            if let name = URL(string: "https://itunes.apple.com/app/id1186228942")
            {
                let objectsToShare = [name]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                activityVC.setValue("Insight", forKey: "subject")
                viewController = activityVC
            }
            else
            {
                print("Sharing is not available")
            }
        }
        else if index == 9{
            
            let sb = UIStoryboard.init(name: "Home", bundle: Bundle.main)
            viewController = sb.instantiateViewController(withIdentifier: "LogoutVC")
        }
        
//        viewController.isTransitionEnabled = true
//        viewController.transitionAnimation = .circleReveal(from: AppDelegate.shared.window!.center, mask: .backgroundGrey)

        
        return viewController
    }
    
    func navigate(to viewController: UIViewController, isLogOut: Bool = false, toBePresented: Bool = false) {
        guard let delegate = self.delegate else {
            return
        }
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                if toBePresented{
                    delegate.present(viewController, animated: true, completion: nil)
                    
                }else if isLogOut {
                    
                    viewController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                    viewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                    delegate.present(viewController, animated: true, completion: nil)
                    
                }else{
                    delegate.setViewControllers([viewController], animated: true)
                }
            
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard indexPath.row != selectedIndex else {
            return
        }
        if indexPath.row == 8 || indexPath.row == 4 || indexPath.row == 5{
            self.navigate(to: self.getViewController(for: indexPath.row ), isLogOut: false, toBePresented: true)
            
        }else if indexPath.row == 9 {
            self.navigate(to: self.getViewController(for: indexPath.row ), isLogOut: true, toBePresented: false)
            
        }else{
            selectedIndex = indexPath.row
            self.navigate(to: self.getViewController(for: indexPath.row ))
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        if indexPath.section == 0{
//
//            return tableView.frame.size.height / CGFloat(Section1MenuItems.count + 1)
//
//        }else if indexPath.section == 1{
//
//            return tableView.frame.size.height / CGFloat(Section2MenuItems.count + 1)
//        }
//
//        return 0
//    }
    
	func reset() {
		selectedIndex = 0
        self.navigate(to: self.getViewController(for: selectedIndex ))
//        tableView?.selectRow(at: IndexPath(row: selectedIndex, section: 0), animated: false, scrollPosition: .none)
	}

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuTableViewCell
        
        cell.img.image = UIImage.init(named: MenuItems[indexPath.row])
        cell.lblTitle.text = MenuItems[indexPath.row]
        
        if MenuItems[indexPath.row] == "Flagged"{
            
            var flaggedQuestionsCounter = 0
            if let realm = try? Realm(){
                
                flaggedQuestionsCounter = realm.objects(FlaggedQuestion.self).count
            }
            
            let lbl = UILabel.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: (0.2 * cell.bounds.width), height: cell.bounds.height)))
            lbl.text = "\(flaggedQuestionsCounter)"
            lbl.font = getFont(17, MavenProMedium)
            let view = UIView.init(frame: CGRect.init(origin: CGPoint.init(x: (cell.contentView.bounds.maxX * 0.75) - lbl.bounds.width, y: 0) , size: CGSize.init(width: (0.2 * cell.bounds.width), height: cell.bounds.height)))
            view.tag = 100
            view.addSubview(lbl)
            for view in cell.contentView.subviews{
                
                if view.tag == 100{
                    view.removeFromSuperview()
                }
            }
            cell.contentView.addSubview(view)
        }
        
        return cell
    }
}


extension SideMenuViewController: StoryboardLoadable { }
