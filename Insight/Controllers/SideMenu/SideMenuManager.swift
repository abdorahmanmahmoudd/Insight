//
//  SideMenuManager.swift
//  DHCR
//
//  Created by Fady on 11/27/17.
//  Copyright © 2017 LinkDevelopment. All rights reserved.
//

import UIKit

class SideMenuManager: NSObject {
	static let shared: SideMenuManager = SideMenuManager()
	
	private weak var navigationController: UINavigationController?
	
	private let presentationInteractionController: SideMenuPresentationInteractionController = .init()
	
	private let dismissalInteractionController: SideMenuDismissalInteractionController = .init()
	
	public var sideMenu: SideMenuViewController = .instantiateFromStoryboard()
	
	override private init() {
		super.init()
        
		sideMenu.transitioningDelegate = self
		sideMenu.modalPresentationStyle = .overFullScreen

	}
	
	func wire(to navigationController: UINavigationController) {
		presentationInteractionController.wire(to: navigationController)
		self.navigationController = navigationController
	}
	
	func unwire() {
		presentationInteractionController.unwire()
	}
	
	func show(from navigationController: UINavigationController) {
		if navigationController !== self.navigationController {
			unwire()
			wire(to: navigationController)
		}
        navigationController.present(sideMenu, animated: true) {
            self.dismissalInteractionController.wire(to: self.sideMenu)
        }
        
    }
	
	func reset() {
		sideMenu.reset()
	}
}

extension SideMenuManager: UIViewControllerTransitioningDelegate {
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return SideMenuAnimationController(direction: .reverse)
	}
	
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return SideMenuAnimationController(direction: .forward)
	}
	
	func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		guard self.presentationInteractionController.interactionInProgress else {
			return nil
		}
		return self.presentationInteractionController
	}
	
	func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		guard self.dismissalInteractionController.interactionInProgress else {
			return nil
		}
		return self.dismissalInteractionController
	}
}
