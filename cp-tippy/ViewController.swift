//
//  ViewController.swift
//  cp-tippy
//
//  Created by Jay on 9/29/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        var tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        
        let defaults = UserDefaults.standard
        let roundTip = defaults.bool(forKey: "roundTip")
        
        if (roundTip) {
            tip = ceil(tip)
        }
        print(roundTip)
        
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        
        let defaultChanged = defaults.bool(forKey: "defaultChanged")
        if (defaultChanged) { // only update segment if the default is changed
            let intValue = defaults.integer(forKey: "tipIndex")
            tipControl.selectedSegmentIndex = intValue
            defaults.set(false, forKey: "defaultChanged") // updated
        }
        
        self.calculateTip(self)
    }
}

