//
//  WebViewController.swift
//  Discover-Atlanta
//
//  Created by jos on 11/1/16.
//  Copyright © 2016 myOrganization. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    var rowInfowebView : Place?
    var webURL,titleName : String?
    
    @IBOutlet weak var myWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = titleName!
        
        let url = NSURL(string: webURL!)
        let requestObj = NSURLRequest(url: url as! URL)
        myWebView.loadRequest(requestObj as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
