//
//  Challenge1ViewController.swift
//  CustomScrollView
//
//  Created by HOMWAY on 30/06/2017.
//  Copyright © 2017 ihomway. All rights reserved.
//

import UIKit

class Challenge1ViewController: UIViewController {
	@IBOutlet weak var greenView: UIView!
	@IBOutlet weak var container: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension Challenge1ViewController {
	@IBAction func changeFrameX(slider: UISlider) {
		greenView.frame.origin.x = CGFloat(slider.value)
	}
	
	@IBAction func changeFrameY(slider: UISlider) {
		greenView.frame.origin.y = CGFloat(slider.value)
	}
	
	@IBAction func changeBoundsX(slider: UISlider) {
		container.bounds.origin.x = CGFloat(slider.value)
	}
	
	@IBAction func changeBoundsY(slider: UISlider) {
		container.bounds.origin.y = CGFloat(slider.value)
	}
}
