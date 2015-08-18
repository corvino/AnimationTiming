//
//  ExampleViewController.swift
//  AnimationTiming
//
//  Created by Nathan Corvino on 5/12/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

import Cocoa

class ExampleViewController: NSViewController {

    @IBOutlet weak var targetView: NSView!

    @IBOutlet var leftConstraint : NSLayoutConstraint!
    var rightConstraint : NSLayoutConstraint!

    var left = true;
    var timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)

    override func viewDidLoad() {
        super.viewDidLoad()

        rightConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: targetView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 20)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "timingFunctionChanged:", name: "TimingFunctionChanged", object: nil)
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func viewWillAppear() {
        if (nil == targetView.layer?.sublayers) {
            let gradient = CAGradientLayer()
            gradient.frame = targetView.bounds
            gradient.colors = [NSColor.lightGrayColor().CGColor, NSColor.redColor().CGColor]
            gradient.endPoint = CGPoint(x: 0, y: 1)
            gradient.startPoint = CGPoint(x: 1, y: 0)
            gradient.cornerRadius = gradient.bounds.size.width / 2
            gradient.borderWidth = 3
            gradient.borderColor = NSColor.darkGrayColor().CGColor

            targetView.layer?.addSublayer(gradient)
        }
    }

    @IBAction func targetClicked(sender: AnyObject) {

        if (left) {
            view.removeConstraint(leftConstraint)
            view.addConstraint(rightConstraint)
        } else {
            view.removeConstraint(rightConstraint)
            view.addConstraint(leftConstraint)
        }

        left = !left

        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            context.duration = 1.2
            context.timingFunction = self.timingFunction
            context.allowsImplicitAnimation = true;
            self.view.updateConstraintsForSubtreeIfNeeded()
            self.view.layoutSubtreeIfNeeded()
        }, completionHandler: { () -> Void in })
    }

    func timingFunctionChanged(notification: NSNotification) {
        timingFunction = notification.userInfo!["TimingFunction"] as! CAMediaTimingFunction
    }
}

