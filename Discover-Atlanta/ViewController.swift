//
//  ViewController.swift
//  Discover-Atlanta
//
//  Created by jos on 10/25/16.
//  Copyright © 2016 myOrganization. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (FBSDKAccessToken.current()) != nil {
            let TabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")
                self.present(TabBarVC!, animated: true, completion: nil)
            //print("Token: \(currenttoken)")
        }
        
        self.view.addSubview(loginButton)
        loginButton.center = self.view.center
        loginButton.delegate = self
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        // to know weather user is logged in or out
//        if (FBSDKAccessToken.current()) != nil{
//            fetchProfile()
//            print("user currently loogged in")
//            let TabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")
//            self.present(TabBarVC!, animated: true, completion: nil)
//        }else {
//            print("user is not logged in")
//        }
//    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        //print("user just logged in")
        let TabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")
        self.present(TabBarVC!, animated: true, completion: nil)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //print("user just logged out")
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        //print("loginButtonWillLogin")
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

