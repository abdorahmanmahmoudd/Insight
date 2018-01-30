//
//  MenuDismissalInteractionController.swift
//  DHCR
//
//  Created by Fady on 11/26/17.
//  Copyright © 2017 LinkDevelopment. All rights reserved.
//

import UIKit

class SideMenuDismissalInteractionController: InteractionController {
	
	fileprivate var shouldCompleteTransition = false
	private weak var viewController: UIViewController?
	private weak var panGesture: UIGestureRecognizer?
	private weak var tapGesture: UIGestureRecognizer?
	
	func wire(to viewController: UIViewController) {
		if let gesture = panGesture {
			self.viewController?.view.superview?.removeGestureRecognizer(gesture)
		}
		
		if let gesture = tapGesture {
			self.viewController?.view.superview?.removeGestureRecognizer(gesture)
		}
		self.viewController = viewController
		prepareGestureRecognizer(in: viewController.view.superview ?? UIView())
	}
	
	private func prepareGestureRecognizer(in view: UIView) {
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
		self.panGesture = panGesture
		panGesture.delegate = self
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
		self.tapGesture = tapGesture
		tapGesture.delegate = self
		
		view.addGestureRecognizer(panGesture)
		view.addGestureRecognizer(tapGesture)
	}
	
	@objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
		let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
		var progress = (-translation.x / gestureRecognizer.view!.superview!.bounds.size.width)
		progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
		
		switch gestureRecognizer.state {
		case .began:
			interactionInProgress = true
			viewController?.dismiss(animated: true, completion: nil)
		case .changed:
			shouldCompleteTransition = progress > 0.25
			update(progress)
		case .cancelled:
			cancel()
			interactionInProgress = false
		case .ended:
			if shouldCompleteTransition || gestureRecognizer.velocity(in: gestureRecognizer.view?.superview).x < 10  {
				finish()
			} else {
				cancel()
			}
			interactionInProgress = false
		default:
			break
		}
	}
	
	@objc func handleTap(_ gestureRecognizer: UIPanGestureRecognizer) {
		viewController?.dismiss(animated: true, completion: nil)
	}
}

extension SideMenuDismissalInteractionController: UIGestureRecognizerDelegate {
	func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		if gestureRecognizer === tapGesture && viewController!.view.frame.contains(gestureRecognizer.location(in: viewController!.view.superview!)) {
			return false
		} else {
			return true
		}
	}
}
