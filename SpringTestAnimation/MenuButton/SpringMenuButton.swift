//
//  SpringMenuButton.swift
//  SpringTestAnimation
//
//  Created by Sauvik Dolui on 17/09/15.
//  Copyright (c) 2015 Innofied Solution Pvt. Ltd. All rights reserved.
//

import UIKit
@objc protocol SpringMenuButtonDelegate : NSObjectProtocol {
    optional func didTapOnButton(sender:UIButton, atIndex: Int)
    optional func didTapOnSpringButton(sender:UIButton)
}

class SpringMenuButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var isButtonTapped: Bool = false
    var crossImageView: UIImageView?
    var normalBackGroundColor: UIColor = UIColor(red: 70.0/255.0, green: 210.0/255.0, blue: 254.00/255.0, alpha: 1.0)
    var tappedBackGroundColor: UIColor = UIColor.whiteColor()
    var buttonColor: UIColor = UIColor(red: 109.0/255.0, green: 11.0/255.0, blue: 216.00/255.0, alpha: 1.0)
    var delegate: AnyObject?
    var parentView: UIView?
    var arrayOfButtons: [MovableButton] = [MovableButton]()
    var delegateVC: protocol<SpringMenuButtonDelegate>?
    
    var semiTransparentView : UIView {
        var semiTransparentView = UIView(frame: UIScreen.mainScreen().bounds)
        semiTransparentView.backgroundColor = UIColor(white:1.0, alpha: 0.8)
        return semiTransparentView
    }

    var numberOfButtons: Int = 0 {
        didSet(newValue) {
           self.addButtons()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        primarySetUp()
        // Adding the cross button
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        primarySetUp()
    }
    
    
    func primarySetUp() {
        layer.cornerRadius = CGRectGetWidth(frame) / 2 // Making it round
        backgroundColor = normalBackGroundColor
        
        // Adding an image view
        let sizeFactor:CGFloat = 0.25
        crossImageView = UIImageView(frame: CGRectMake(0, 0, frame.width * sizeFactor, frame.height * sizeFactor))
        crossImageView?.image = UIImage(named: "cross")
        crossImageView?.center = CGPointMake(frame.width/2, frame.height/2)
        addSubview(crossImageView!)
        
        // Addding selector on tap event
        self.addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchDown)
        self.clipsToBounds = false
    
    }
    
    func buttonTapped(sender: UIButton){
        isButtonTapped = !isButtonTapped
        if isButtonTapped {
            expand()
        } else {
            collapse()
        }
    }
    private func expand() {
        
        if let delegateVC = self.delegateVC {
            //(delegateVC as! UIViewController).view.addSubview(semiTransparentView)
        }
        
        // 1.
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.50, initialSpringVelocity: 10, options: .CurveEaseInOut | .AllowUserInteraction, animations: { () -> Void in
            self.crossImageView?.transform = CGAffineTransformRotate(self.crossImageView!.transform, CGFloat( 135 * M_PI/180))
            self.backgroundColor = self.tappedBackGroundColor
            }, completion: { (Bool) -> Void in
                
        })
        self.unhideButtons()
    }
    
    private func collapse() {
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.50, initialSpringVelocity: 10, options: .CurveEaseInOut | .AllowUserInteraction, animations: { () -> Void in
            self.crossImageView?.transform = CGAffineTransformRotate(self.crossImageView!.transform, CGFloat( 135 * -M_PI/180))
            self.backgroundColor = self.normalBackGroundColor
            }, completion: { (Bool) -> Void in
                if let delegateVC = self.delegateVC {
                    self.semiTransparentView.removeFromSuperview()
                }
        })
        self.hideButtons()
    }
    func hideButtons() {
        for movableButton in arrayOfButtons {
            movableButton.hide()
        }
    }
    func unhideButtons() {
        for movableButton in arrayOfButtons {
            movableButton.unhide()
        }
    }
    
    func addButtons() {
        // Adding a sinle button
        for i in 0..<numberOfButtons {
            var movableButton = MovableButton(frame: frame)
            movableButton.tag = i
            movableButton.backgroundColor = buttonColor
            movableButton.setPositionParameter(CGFloat(i + 1) * 0.0, dy: CGFloat(i + 1) * -frame.height * 1.25)
            superview!.addSubview(movableButton)
            superview!.sendSubviewToBack(movableButton)
            movableButton.addTarget(self, action: "menuButtonTapped:", forControlEvents: UIControlEvents.TouchDown)
            arrayOfButtons.append(movableButton)
        }
    }
    func menuButtonTapped(sender: MovableButton){
        sender.animation = "wobble"
        sender.animate()
        
        if let delegateVC = self.delegateVC {
            delegateVC.didTapOnButton!(sender, atIndex:sender.tag)
            // Uncomment to allowing collapsing buttons while single button is tapped
//            isButtonTapped = !isButtonTapped
//            collapse()
        }
    }
    
    func semitransparentBG() -> UIView {
        var semiTransparentView = UIView(frame: UIScreen.mainScreen().bounds)
        semiTransparentView.backgroundColor = UIColor(white: 0.2, alpha: 0.8)
        return semiTransparentView
    }
}
