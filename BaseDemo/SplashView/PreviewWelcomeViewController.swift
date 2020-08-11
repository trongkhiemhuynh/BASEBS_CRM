//
//  PreviewWelcomeViewController.swift
//  BaseDemo
//
//  Created by BASEBS on 8/7/20.
//  Copyright © 2020 BASEBS. All rights reserved.
//

import UIKit

class PreviewWelcomeViewController: UIViewController {

    @IBOutlet weak var ivUser : UIImageView!
    @IBOutlet weak var constraintIvUser: NSLayoutConstraint!
    @IBOutlet weak var ivStick: UIImageView!
    @IBOutlet weak var vCircle: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        ivStick.isHidden = true
        let color = UIColor(hex: "#0AB2A8")
        print(color!)
        vCircle.backgroundColor = color
        vCircle.layer.cornerRadius = vCircle.bounds.width/2
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            self.view.layoutIfNeeded()
            self.constraintIvUser.constant -= 50
            
            UIView.animate(withDuration: 0.35, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (success) in
                self.ivStick.isHidden = false
            })
            
        }
    }
    
    func animationStick() {
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
