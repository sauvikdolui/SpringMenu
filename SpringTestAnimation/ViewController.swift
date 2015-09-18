//
//  ViewController.swift
//  SpringTestAnimation
//
//  Created by Sauvik Dolui on 17/09/15.
//  Copyright (c) 2015 Innofied Solution Pvt. Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SpringMenuButtonDelegate {

    
    @IBOutlet weak var springMenuButton: SpringMenuButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        springMenuButton.numberOfButtons = 4
        springMenuButton.delegateVC = self
    }

    override func viewWillAppear(animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController: SpringMenuButtonDelegate{
    func didTapOnButton(sender: UIButton, atIndex: Int) {
        println("Button tapped -> \(atIndex)")
    }
    
}

