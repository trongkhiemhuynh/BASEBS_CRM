//
//  ViewController.swift
//  BaseDemo
//
//  Created by BASEBS on 8/5/20.
//  Copyright © 2020 BASEBS. All rights reserved.
//

import UIKit
import WebexSDK

class LoginViewController : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginAction(_ sender : AnyObject) {
        
        let router = Router<BaseApi>()
        router.request(<#T##route: BaseApi##BaseApi#>, completion: <#T##(Data?, URLResponse?, Error?) -> Void#>)
        router.request(.login(username: "khiemht@base.com", password: "Admin@1234")) { (data, response, error) in
            print("-------------")
            
            print(data)
        }
        
    }

}

