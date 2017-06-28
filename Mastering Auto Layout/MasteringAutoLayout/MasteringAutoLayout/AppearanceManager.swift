//
//  AppearanceManager.swift
//  MasteringAutoLayout
//
//  Created by Homway on 28/06/2017.
//  Copyright © 2017 ihomway. All rights reserved.
//

import UIKit

class AppearanceManager {
	class func setupAppearance() {
		let navBarAppearance = UINavigationBar.appearance(for: UITraitCollection(horizontalSizeClass: .unspecified))
		navBarAppearance.titleTextAttributes = [NSFontAttributeName: UIFont(name: "MarkerFelt-Wide", size: 22)!]

		let navBarCompactAppearance = UINavigationBar.appearance(for: UITraitCollection(horizontalSizeClass: .compact))
		navBarCompactAppearance.titleTextAttributes = [NSFontAttributeName: UIFont(name: "MarkerFelt-Wide", size: 14)!]
	}
}
