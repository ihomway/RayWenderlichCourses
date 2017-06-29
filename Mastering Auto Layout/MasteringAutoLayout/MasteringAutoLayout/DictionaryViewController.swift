//
//  DictionaryViewController.swift
//  MasteringAutoLayout
//
//  Created by HOMWAY on 29/06/2017.
//  Copyright © 2017 ihomway. All rights reserved.
//

import UIKit

class DictionaryViewController: UITableViewController {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		let rightButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(DictionaryViewController.dismissAction))
		self.navigationItem.rightBarButtonItem = rightButtonItem
		
		let backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "bg-parchment"))
		backgroundImageView.contentMode = .center
		tableView.backgroundView = backgroundImageView
	}
	
	func dismissAction() {
		dismiss(animated: true, completion: nil)
	}
}

extension DictionaryViewController: UIPopoverPresentationControllerDelegate {
	func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
		return UINavigationController(rootViewController: controller.presentedViewController)
	}
}
