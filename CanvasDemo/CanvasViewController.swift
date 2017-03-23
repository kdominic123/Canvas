//
//  CanvasViewController.swift
//  CanvasDemo
//
//  Created by Kenan Dominic on 3/23/17.
//  Copyright © 2017 Kenan Dominic. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!

    var newlyCreatedFace: UIImageView!
    var trayOriginalCenter: CGPoint!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        trayDownOffset = 220
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
    
        let translation = sender.translation(in: view)
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == .began {
            
            self.trayOriginalCenter = trayView.center
        } else if sender.state == .changed {
            
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
        
            if velocity.y > 0 {
         
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayDown
                }, completion: nil)
            } else {
                
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayUp
                }, completion: nil)
            }
        }
    }
    
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        if sender.state == .began {

            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            UIView.animate(withDuration: 0.2, animations: {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            })
            
            // Here we use the method didPan(sender:), which we defined in the previous step, as the action.
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onMoving(sender:)))

            
            // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
        } else if sender.state == .changed {
        
            let translation = sender.translation(in: view)
            
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        
        } else if sender.state == .ended {
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
            
        }
    }
    
    func onMoving(sender: UIPanGestureRecognizer) {
     
        let translation = sender.translation(in: view)
        
        if(sender.state == .began) {
            
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
        } else if(sender.state == .changed) {
            
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if(sender.state == .ended) {
            
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
