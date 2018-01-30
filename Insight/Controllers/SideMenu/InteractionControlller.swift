//
//  InteractionControlller.swift
//  DHCR
//
//  Created by Fady on 11/26/17.
//  Copyright © 2017 LinkDevelopment. All rights reserved.
//

import UIKit

class InteractionController: UIPercentDrivenInteractiveTransition {
	var interactionInProgress = false
	
	override func update(_ percentComplete: CGFloat) {
		super.update(percentComplete)
	}
	
	override func cancel() {
		if self.interactionInProgress {
			update(0)
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
				super.cancel()
			}
		}
	}
	
	override func finish() {
		if self.interactionInProgress {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
				super.finish()
			}
		}
	}
}

