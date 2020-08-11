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
        
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "SplashViewID")
//
//        present(vc, animated: false) {
//            print("xxx")
//        }
        
        let clientId = "Cc7295dda94de7fc44826cc096e448b50520a93cf1f8ec98c5384715641a6c9ca"
        let clientSecret = "4cafb64a4a956c84f7a787bfb74031ce89a7937fd82297ac860d9534d4447292"
        let scope = "spark:all"
        let redirectUri = "Basedemo://response"
        
        let authenticator = OAuthAuthenticator(clientId: clientId, clientSecret: clientSecret, scope: scope, redirectUri: redirectUri)
        
        let webex = Webex(authenticator: authenticator)
        
    
        if !authenticator.authorized {
            authenticator.authorize(parentViewController: self) { success in
                if !success {
                    print("User not authorized")
                }
            }
        }
        
        
    }

}

