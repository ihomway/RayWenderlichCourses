//
//  TestingViewController.swift
//  MasteringAutoLayout
//
//  Created by HOMWAY on 28/06/2017.
//  Copyright © 2017 ihomway. All rights reserved.
//

import UIKit

class TestingViewController: UIViewController {

	let countOfViews = 3
	var coloredViews = [UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
			
			let hSpace:CGFloat = 8
			let vSpace: CGFloat = 20
			let viewWidth: CGFloat = 50
			
			let colors: [UIColor] = [.red, .green, .blue]
			for index in 0..<countOfViews {
				let view = UIView()
				view.backgroundColor = colors[index]
				view.translatesAutoresizingMaskIntoConstraints = false
				self.view.addSubview(view)
				coloredViews.append(view)
			}
			
			var contarints = [NSLayoutConstraint]()
			let views:[String: Any] = ["red": coloredViews[0], "green": coloredViews[1], "blue": coloredViews[2]]
			let metrics:[String: Any] = ["hSpace": hSpace, "vSpace": vSpace, "viewWidth": viewWidth]
			contarints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=0)-[red(viewWidth)]-(hSpace)-[green(==red)]-(hSpace)-[blue(==red)]-(>=0)-|", metrics: metrics, views: views))
			contarints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=0)-[red(viewWidth)]-(vSpace)-[green(==red)]-(vSpace)-[blue(==red)]-(>=0)-|", metrics: metrics, views: views))
			coloredViews[1].centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
			coloredViews[1].centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
			NSLayoutConstraint.activate(contarints)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
