//
//  ViewController.swift
//  SpringTestAnimation
//
//  Created by Sauvik Dolui on 17/09/15.
//  Copyright (c) 2015 Innofied Solution Pvt. Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SpringMenuButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var buttonWidth: CGFloat = 60
        var screenSize = UIScreen.mainScreen().bounds
        var newButton = SpringMenuButton(frame: CGRectMake((screenSize.width - buttonWidth)/2, screenSize.height - buttonWidth * 1.5,
                                            buttonWidth, buttonWidth))
        self.view.addSubview(newButton)
        newButton.numberOfButtons = 3
        newButton.delegateVC = self
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

