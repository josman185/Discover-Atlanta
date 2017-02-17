//
//  LogOutViewController.swift
//  Discover-Atlanta
//
//  Created by jos on 10/26/16.
//  Copyright © 2016 myOrganization. All rights reserved.
//

import UIKit

class LogOutViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imageLbl: UIImageView!
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(loginButton)
        loginButton.center = self.view.center
        loginButton.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadLogInView(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let TabBarVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(TabBarVC, animated: false, completion: nil)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        //user just logged in
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        loadLogInView() //user just logged out
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        //print("loginButtonWillLogin")
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (FBSDKAccessToken.current()) != nil{
            fetchProfile()
        }else{
            loadLogInView()
        }
    }
    
    func fetchProfile(){
        
        let parameters = ["fields":"email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {
            (connection, result, error) -> Void in
            
            if error != nil {
                print(error!)
                return
            }

            if let results = result as? [String: Any]{
                if let name = results["first_name"] as? String{
                    self.nameLbl.text = name
                }
                if let picture = results["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary, let url = data["url"] as? String {
                    //print(url)
                    
                    if (url != "") {
                        DispatchQueue.global(qos: .userInitiated).async {
                            let img = ImageDownloader.withURL(url)
                            DispatchQueue.main.async {
                                self.imageLbl.image = img
                            }
                        }
                    }else{
                        self.imageLbl.image = UIImage(named: "not_found-1.jpg")
                    }
                    
                }
            }
            //print(result!)
        })
    }
}
