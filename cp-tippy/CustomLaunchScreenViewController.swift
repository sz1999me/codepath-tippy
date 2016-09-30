//
//  CustomLaunchScreenViewController.swift
//  cp-tippy
//
//  Created by Jay on 9/29/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class CustomLaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let view = AnimatedEqualizerView(containerView: animationContainer)
        self.animationContainer.backgroundColor = UIColor.clear
        self.animationContainer.addSubview(view)
        view.animate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var animationContainer: UIView!

}
