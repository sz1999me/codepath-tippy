//
//  SettingsViewController.swift
//  cp-tippy
//
//  Created by Jay on 9/29/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var roundTipSwitch: UISwitch!

    @IBAction func defaultTipChanged(_ sender: AnyObject) {
        let tipIndex = tipControl.selectedSegmentIndex
        
        let defaults = UserDefaults.standard
        defaults.set(tipIndex, forKey: "tipIndex")
        defaults.set(true, forKey: "defaultChanged")
        defaults.synchronize()
    }
    
    @IBAction func roundTipSwitchChanged(_ sender: AnyObject) {
        let isOn = roundTipSwitch.isOn
        
        let defaults = UserDefaults.standard
        defaults.set(isOn, forKey: "roundTip")
        defaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        let intValue = defaults.integer(forKey: "tipIndex")
        let roundTipBool = defaults.bool(forKey: "roundTip")
        
        tipControl.selectedSegmentIndex = intValue
        roundTipSwitch.setOn(roundTipBool, animated: false)
    }
}
