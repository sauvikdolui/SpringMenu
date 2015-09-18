//
//  MovableButton.swift
//  SpringTestAnimation
//
//  Created by Sauvik Dolui on 17/09/15.
//  Copyright (c) 2015 Innofied Solution Pvt. Ltd. All rights reserved.
//

import UIKit

class MovableButton: SpringButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var primaryOrigin: CGPoint = CGPointZero
    var originalFrame: CGRect = CGRectZero
    var finalOrigin: CGPoint = CGPointZero
    var dY: CGFloat = 0.0
    var sizeToDecrease: CGFloat = 0.0
    
    var hideDelay = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        originalFrame = self.frame
        primarySetUp()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        primarySetUp()
        
    }
    
    func primarySetUp() {
        layer.cornerRadius = CGRectGetWidth(frame) / 2
        self.backgroundColor = UIColor.yellowColor()
        primaryOrigin = frame.origin
        self.clipsToBounds = true
        
    }
    func setPositionParameter(dx: CGFloat, dy: CGFloat) {
        finalOrigin = CGPointMake(frame.origin.x + dx, frame.origin.y + dy)
        hideDelay = 0.085/100.0 * fabs(Double(dy))
    }
    func unhide() {
        self.frame = originalFrame
        //self.layer.cornerRadius = self.frame.width / 2
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10.0, options: .CurveEaseInOut, animations: { () -> Void in
            self.frame = CGRectMake(self.finalOrigin.x, self.finalOrigin.y, self.frame.width, self.frame.height)
            self.layer.cornerRadius = self.frame.width / 2
            self.layer.opacity = 1.0
        }, completion: nil)
        
    }
    
    func hide(){

        var newX = frame.origin.x + frame.width * sizeToDecrease / 2
        var newWidth = frame.width - frame.width * sizeToDecrease
        var newHeight = frame.height - frame.height * sizeToDecrease
        
        UIView.animateWithDuration(1.0, delay: hideDelay, usingSpringWithDamping: 1.0, initialSpringVelocity: 10.0, options:.CurveEaseInOut, animations: { () -> Void in
            self.frame = CGRectMake(self.primaryOrigin.x, self.primaryOrigin.y, self.frame.width, self.frame.height)
            //self.transform = CGAffineTransformScale(self.transform, 0.4, 0.4)
        }) { (finished) -> Void in
            
            //self.layer.cornerRadius = newWidth / 2
        }
        UIView.animateWithDuration(1.0, delay: hideDelay, usingSpringWithDamping: 1.0, initialSpringVelocity: 10.0, options:.CurveEaseOut, animations: { () -> Void in
            //self.transform = CGAffineTransformScale(self.transform , 0.40, 0.40)
            var transform = self.layer.affineTransform()
            transform = CGAffineTransformScale(transform, 0.4, 0.4)
            
            }) { (finished) -> Void in
                var transform = self.layer.affineTransform()
               transform = CGAffineTransformScale(transform, 1.0, 1.0)
        }
    }

}
