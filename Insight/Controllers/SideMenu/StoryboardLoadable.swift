//
//  StoryboardLoadable.swift
//  DMCA
//
//  Created by Fady on 8/7/17.
//  Copyright © 2017 Fady Ackad. All rights reserved.
//

import UIKit

protocol StoryboardLoadable: class {
	static var storyboardName: String { get }
	static var storyboardIdentifier: String { get }
}

extension StoryboardLoadable where Self: UIViewController {
	
	static var storyboardName: String {
		return String(describing: self)
	}
	
	static var storyboardIdentifier: String {
		return String(describing: self)
	}
	
	static func instantiateFromStoryboard() -> Self {
		return Storyboard(name: storyboardName).instatiate(Self.self)
	}
}
