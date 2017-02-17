//
//  DetailMainTableVC.swift
//  Discover-Atlanta
//
//  Created by jos on 10/29/16.
//  Copyright © 2016 myOrganization. All rights reserved.
//

import UIKit

class DetailMainTableVC: UIViewController {
    
    var rowInfo : Place?

    @IBOutlet weak var imageDetailLbl: UIImageView!
    @IBOutlet weak var titleDetailLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = rowInfo?.name
        titleDetailLbl.text = rowInfo?.name
        descriptionLbl.text = rowInfo?.description
        
        if (rowInfo?.urlToImage! != nil) {
            DispatchQueue.global(qos: .userInitiated).async {
                let img = ImageDownloader.withURL(self.rowInfo?.urlToImage!)
                DispatchQueue.main.async {
                    self.imageDetailLbl.image = img
                }
            }
        }else{
            self.imageDetailLbl.image = UIImage(named: "not_found-1.jpg")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToMapView" {
            let mapViewVC = segue.destination as! MapViewController
            let row = rowInfo
            mapViewVC.rowInfo = row
        }
        if segue.identifier == "segueToVideoView" {
            let videoVC = segue.destination as! VideoViewController
            let row = rowInfo
            videoVC.rowInfoVideoView = row
        }
        if segue.identifier == "segueToWebView" {
            let webVC = segue.destination as! WebViewController
            let url = rowInfo!.url!
            let name = rowInfo!.name!
            webVC.webURL = url
            webVC.titleName = name
        }
    }
    
}
/*
class Downloader {
    
    class func downloadImageWithURL(_ url:String?) -> UIImage! {
        
        
        
        //let data = try? Data(contentsOf: URL(string: url!)!)
        //return UIImage(data: data!)
    }
}
*/
