//
//  HomeView.swift
//  JustGo
//
//  Created by Kyle Zappitell on 1/21/16.
//  Copyright © 2016 Kyle Zappitell. All rights reserved.
//

import UIKit

class HomeView: UIViewController {
    
    @IBOutlet weak var flyLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var plane: UIImageView!
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    
    var location = CGPoint(x:85 , y: 200)
    var size = CGSize(width: 200, height: 240)
    var selection: Bool = false
    var localBool: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plane.frame = CGRect(origin: location, size: size)
        planeBounce()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if let viewController: JustGoView = segue.destinationViewController as? JustGoView
        {
            viewController.localBool = localBool
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let touch = touches.first as UITouch!
        print(touch.locationInView(self.view))
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let touch = touches.first as UITouch!
        if(touch.locationInView(self.view).y > 400)
        {
            UIView.animateWithDuration(0.2, animations: {self.localLabel.alpha = 0.5}, completion: nil)
        }
        else if(touch.locationInView(self.view).y < 200)
        {
            UIView.animateWithDuration(0.2, animations: {self.flyLabel.alpha = 0.5}, completion: nil)
        }
        else
        {
            self.localLabel.alpha = 0
            self.flyLabel.alpha = 0
        }
        
        if(!selection)
        {
            location.y = touch.locationInView(self.view).y - (0.5 * size.height)
            plane.frame = CGRect(origin: location, size: size)
        }
    }
    override func touchesEnded(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        let touch = touches?.first as UITouch!
        print(touch.locationInView(self.view))
        if(touch.locationInView(self.view).y > 400 && selection == false)
        {
            selection = true;
            touch.view?.userInteractionEnabled = false;
            print("Switch Views Local")
            planeNoFly()
        }
        else if(touch.locationInView(self.view).y < 200 && selection == false)
        {
            selection = true;
            touch.view?.userInteractionEnabled = false;
            print("Switch Views Plane")
            planeFly()
        }
        if(!selection)
        {
            location.y = 200
            plane.frame = CGRect(origin: location, size: size)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func planeBounce()
    {
        UIView.animateWithDuration(2.0) { () -> Void in
            self.blurEffect.alpha = 0
        }
        UIView.animateWithDuration(2.0, delay: 1.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 10, options: .BeginFromCurrentState, animations: { () -> Void in
            self.location.y = self.location.y + 70
            self.plane.frame = CGRect(origin: self.location, size: self.size)
            //self.location.y = self.location.y - 70
            //self.plane.frame = CGRect(origin: self.location, size: self.size)
            }) { (complete) -> Void in
            print(complete)
        }
    }
    
    func planeNoFly()
    {
        UIView.animateWithDuration(0.6, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
            {
                self.location.y = self.location.y + 300
                self.plane.frame = CGRect(origin: self.location, size: self.size)
            }, completion: {finished in
            if(finished)
            {
                print("finished!")
                self.localBool = true
                sleep(1)
                self.performSegueWithIdentifier("toJustGo", sender: nil)
            }
        })
    }
    
    func planeFly()
    {
        UIView.animateWithDuration(0.6, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
            {
                self.location.y = self.location.y - 300
                self.plane.frame = CGRect(origin: self.location, size: self.size)
            }, completion: {finished in
                if(finished)
                {
                    print("finished!")
                    self.localBool = false
                    sleep(1)
                    self.performSegueWithIdentifier("toJustGo", sender: nil)
                }
        })
    }

}