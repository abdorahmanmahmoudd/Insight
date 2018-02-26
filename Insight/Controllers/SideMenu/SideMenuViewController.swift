//
//  SideMenuViewController.swift
//  DHCR
//
//  Created by Fady on 11/26/17.
//  Copyright © 2017 LinkDevelopment. All rights reserved.
//

import UIKit

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
            
        }else if index == 3{
            
            let sb = UIStoryboard.init(name: "Flag", bundle: Bundle.main)
            viewController = sb.instantiateViewController(withIdentifier: "FlagVC")
            
        }else if index == 5{
            
            let sb = UIStoryboard.init(name: "Home", bundle: Bundle.main)
            viewController = sb.instantiateViewController(withIdentifier: "ResultsVC")
        }
        
        
        
//        viewController.isTransitionEnabled = true
//        viewController.transitionAnimation = .circleReveal(from: AppDelegate.shared.window!.center, mask: .backgroundGrey)

        
        return viewController
    }
    
    func navigate(to viewController: UIViewController) {
        guard let delegate = self.delegate else {
            return
        }
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                delegate.setViewControllers([viewController], animated: true)
//                delegate.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard indexPath.row != selectedIndex else {
            return
        }
        selectedIndex = indexPath.row
        
        self.navigate(to: self.getViewController(for: selectedIndex ))
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
		tableView?.selectRow(at: IndexPath(row: selectedIndex, section: 0), animated: false, scrollPosition: .none)
	}

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuTableViewCell
        
        cell.img.image = UIImage.init(named: MenuItems[indexPath.row])
        cell.lblTitle.text = MenuItems[indexPath.row]
        
        
        return cell
    }
}


extension SideMenuViewController: StoryboardLoadable { }
