//
//  ViewController.swift
//  UIDynamicAnimationSnapping
//
//  Created by Art Karma on 4/24/19.
//  Copyright © 2019 Art Karma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var animator: UIDynamicAnimator!
    var snapping: UISnapBehavior!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        snapping = UISnapBehavior(item: imageView, snapTo: self.view.center)
        snapping.damping = -0.2
        animator.addBehavior(snapping)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(touch(sender:)))
        imageView.addGestureRecognizer(gesture)
        imageView.isUserInteractionEnabled = true
        
   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @objc func touch(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .possible:
            ()
        case .began:
            animator.removeBehavior(snapping)
        case .changed:
            let translation = sender.translation(in: self.view)
            imageView.center = CGPoint(x: imageView.center.x + translation.x, y: imageView.center.y + translation.y)
            sender.setTranslation(.zero, in: self.view)
        case .ended, .cancelled, .failed:
            animator.addBehavior(snapping)
        @unknown default:
            ()
        }
    }
    
}

