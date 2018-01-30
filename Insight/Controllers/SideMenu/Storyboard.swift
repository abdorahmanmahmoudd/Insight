//
//  Storyboard.swift
//  DHCR
//
//  Created by Fady on 11/14/17.
//  Copyright © 2017 LinkDevelopment. All rights reserved.
//

import UIKit

struct Storyboard {
	var name: String
	
	var instance: UIStoryboard {
		return UIStoryboard(name: self.name, bundle: nil)
	}
	
	func instatiate<T: UIViewController>(_: T.Type) -> T where T: StoryboardLoadable  {
		guard let viewController = self.instance.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
			fatalError("unable to instantiate ViewController form storyboard")
		}
		return viewController
	}
}
