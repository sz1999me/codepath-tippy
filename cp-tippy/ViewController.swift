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
    @IBOutlet weak var paxStepper: UIStepper!
    @IBOutlet weak var pricePerPersonLabel: UILabel!
    @IBOutlet weak var numPersonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billField.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let bill = Double(billField.text!) ?? 0
        if bill == 0 {
            billField.becomeFirstResponder()
        }
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        let tipPercentages = [0.1, 0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        var tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        
        let defaults = UserDefaults.standard
        let roundTip = defaults.bool(forKey: "roundTip")
        
        if roundTip {
            tip = ceil(tip)
        }
        
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        self.onPaxChanged(self)
    }
    
    @IBAction func onPaxChanged(_ sender: AnyObject) {
        let pax = paxStepper.value
        
        numPersonLabel.text = String(Int(pax))
        
        let total = totalLabel.text!
        let index1 = total.index(total.startIndex, offsetBy: 1)
        let price = Double(total.substring(from: index1))

        let pricePerPerson = price! / pax
        
        pricePerPersonLabel.text = String(format: "Each person pays $%.2f", pricePerPerson)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        let bill = Double(billField.text!) ?? 0
        
        let defaultChanged = defaults.bool(forKey: "defaultChanged")
        if defaultChanged || bill == 0 { // only update segment if the default is changed
            let intValue = defaults.integer(forKey: "tipIndex")
            tipControl.selectedSegmentIndex = intValue
            defaults.set(false, forKey: "defaultChanged") // updated
        }
        
        self.calculateTip(self)
    }
}

