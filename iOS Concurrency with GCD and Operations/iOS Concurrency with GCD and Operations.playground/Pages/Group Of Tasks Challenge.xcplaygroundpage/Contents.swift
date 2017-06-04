//: [Previous](@previous)

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # UIViewAnimationGroup
//: In the demo, you learned how you can use GCD dispatch groups to be notified when a set of GCD tasks completes, and how you can wrap an existing asynchronous API to use dispatch groups.
//:
//: __Challenge:__ The `UIView` animation API is asynchronous, but doesn't make it easy to determine when multiple simultaneous animations complete. Your challenge is to extend the `UIView` animation API to accept a `DispatchGroup` argument, and hence determine when a set of animations completes.
//:
//: Add an implementation to this new `UIView` API
extension UIView {
	static func animate(withDuration duration: TimeInterval, animations: @escaping () -> Void, group: DispatchGroup, completion: ((Bool) -> Void)?) {
		
  // TODO: Fill in this implementation
		
		group.enter()
		
		animate(withDuration: duration, animations: animations) { bool in
			completion?(bool)
			group.leave()
		}
		
	}
}
//: The animation uses the following views
let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = UIColor.red
let box = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
box.backgroundColor = UIColor.yellow
view.addSubview(box)
//: Use the following dispatch group:
let animationGroup = DispatchGroup()

PlaygroundPage.current.liveView = view
//: __Note:__ Open the assistant editor to see the views
//:
//: __TODO:__ Rewrite the following animation to be notified when all animations complete:

UIView.animate(withDuration: 1, animations: { 
	box.center = CGPoint(x: 150, y: 150)
}, group: animationGroup) { _ in
	
	UIView.animate(withDuration: 2, animations: { 
		box.transform = CGAffineTransform(rotationAngle: .pi/4)
	}, group: animationGroup, completion: nil)
	
}

UIView.animate(withDuration: 4, animations: { 
	view.backgroundColor = UIColor.blue
}, group: animationGroup, completion: nil)
//: This should only print once all the animations are complete
animationGroup.notify(queue: DispatchQueue.main) {
	print("Animations Completed!")
}
//: __Note:__ Manually stop execution of this playground when the animation finishes: click the stop button below.

//: [Next](@next)
