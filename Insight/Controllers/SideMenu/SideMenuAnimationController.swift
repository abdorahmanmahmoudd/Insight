//
//  MenuPresentationAnimationController.swift
//  DHCR
//
//  Created by Fady on 11/26/17.
//  Copyright © 2017 LinkDevelopment. All rights reserved.
//

import UIKit

enum Direction {
    case forward
    case reverse
}

class SideMenuAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
	
	private var animator: UIViewPropertyAnimator!
	
	var direction: Direction
	
	init(direction: Direction) {
		self.direction = direction
		super.init()
	}
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.3
	}
	
	func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
		
		if animator != nil {
			return animator
		}
		
		guard
			let fromViewController = transitionContext.viewController(forKey: .from),
			let toViewController = transitionContext.viewController(forKey: .to)
			else {
				fatalError("Whaaa")
		}
		
		let containerView = transitionContext.containerView
		let inset: CGFloat = containerView.bounds.size.width/8
		
		let sideMenu: UIViewController
		let presentingViewController: UIViewController
		let startX: CGFloat
		let endX: CGFloat
		switch direction {
		case .forward:
			sideMenu = toViewController
			presentingViewController = fromViewController
			sideMenu.view.frame = containerView.frame.insetBy(dx: inset, dy: 0)
			containerView.addSubview(sideMenu.view)
			startX = -containerView.bounds.size.width + 2*inset
			endX = 0
		case .reverse:
			sideMenu = fromViewController
			presentingViewController = toViewController
			startX = 0
			endX = -containerView.bounds.size.width + 2*inset
		}
		
		sideMenu.view.frame.origin = CGPoint(x: startX, y: 0)
		animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), controlPoint1: CGPoint(x: 0.4, y: 0.9), controlPoint2: CGPoint(x: 0.65, y: 1.0)) {
			sideMenu.view.frame.origin = CGPoint(x: endX, y: 0)
			presentingViewController.view.frame.origin = CGPoint(x: -startX, y: 0)
		}
		
		animator.addCompletion { (position) in
			transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
		}
		animator.isInterruptible = true
		animator.isUserInteractionEnabled = false
		return animator
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let animator = interruptibleAnimator(using: transitionContext)
		animator.startAnimation()
	}
	
	func animationEnded(_ transitionCompleted: Bool) {
		animator = nil
	}
}
