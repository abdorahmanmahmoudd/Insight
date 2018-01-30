//
//  MenuPresentationInteractionController.swift
//  DHCR
//
//  Created by Fady on 11/26/17.
//  Copyright © 2017 LinkDevelopment. All rights reserved.
//

import UIKit

class SideMenuPresentationInteractionController: InteractionController {
	
	fileprivate var shouldCompleteTransition = false
	private weak var navigationController: UINavigationController?
	private weak var gesture: UIGestureRecognizer?
	
	func wire(to navigationController: UINavigationController) {
		unwire()
		self.navigationController = navigationController
		prepareGestureRecognizer(in: navigationController.view)
	}
	
	func unwire() {
		if let gesture = gesture {
			self.navigationController?.view.removeGestureRecognizer(gesture)
		}
	}
	
	private func prepareGestureRecognizer(in view: UIView) {
		let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
		gesture.edges = .left
		self.gesture = gesture
		gesture.delegate = self
		view.addGestureRecognizer(gesture)
	}
	
	@objc func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
		let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
		var progress = (translation.x / gestureRecognizer.view!.superview!.bounds.size.width)
		progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
		
		switch gestureRecognizer.state {
		case .began:
			interactionInProgress = true
			SideMenuManager.shared.show(from: navigationController!)
		case .changed:
			shouldCompleteTransition = progress > 0.5
			DispatchQueue.main.async {
				self.update(progress)
			}
		case .cancelled:
			DispatchQueue.main.async {
				self.cancel()
				self.interactionInProgress = false
			}
		case .ended:
			if shouldCompleteTransition || gestureRecognizer.velocity(in: gestureRecognizer.view?.superview).x > 50  {
				DispatchQueue.main.async {
					self.finish()
					self.interactionInProgress = false
				}
			} else {
				DispatchQueue.main.async {
					self.cancel()
					self.interactionInProgress = false
				}
			}
		default:
			break
		}
	}
}

extension SideMenuPresentationInteractionController: UIGestureRecognizerDelegate {
	func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		return navigationController?.viewControllers.count == 1
	}
}
