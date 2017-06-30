//
//  RWScrollView.swift
//  CustomScrollView
//
//  Created by HOMWAY on 30/06/2017.
//  Copyright © 2017 ihomway. All rights reserved.
//

import UIKit

class RWScrollView: UIView {
	
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.clipsToBounds = true
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panInView(pan:)))
		addGestureRecognizer(panGesture)
	}

	func panInView(pan: UIPanGestureRecognizer) {
		let translation = pan.translation(in: self)
		
		UIView.animate(withDuration: 0.20) { 
			self.bounds.origin.y -= translation.y
		}
		
		pan.setTranslation(.zero, in: self)
	}
}
