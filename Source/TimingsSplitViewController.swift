//
//  TimingsSplitViewController.swift
//  Timings
//
//  Created by Nathan Corvino on 8/18/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

import Cocoa

class TimingsSplitViewController : NSSplitViewController {

    @IBOutlet weak var timingCurveSplitViewItem: NSSplitViewItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        let timingCurveViewController = timingCurveSplitViewItem.viewController as! TimingCurveViewController
        timingCurveViewController.bezierWidget.desiredInset = (dx: 40, dy: 200)
    }
}
