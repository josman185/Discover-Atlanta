//
//  LogOutViewController.swift
//  Discover-Atlanta
//
//  Created by jos on 10/26/16.
//  Copyright © 2016 myOrganization. All rights reserved.
//

import UIKit

class LogOutViewController: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imageLbl: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (FBSDKAccessToken.current()) != nil{
            fetchProfile()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonLogOutPressed(_ sender: AnyObject) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
        self.present(VC!, animated: true, completion: nil)
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
                            let img = Downloader.downloadImageWithURL(url)
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
