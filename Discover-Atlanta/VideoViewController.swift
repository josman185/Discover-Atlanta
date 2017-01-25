//
//  VideoViewController.swift
//  Discover-Atlanta
//
//  Created by jos on 10/31/16.
//  Copyright © 2016 myOrganization. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {
    
    @IBOutlet weak var videoView: UIWebView!
    var rowInfoVideoView : Place?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = rowInfoVideoView?.name!
        
        videoView.allowsInlineMediaPlayback = true
        
        videoView.loadHTMLString("<iframe width=\"\(videoView.frame.width)\" height=\"\(videoView.frame.height)\" src=\"\(rowInfoVideoView!.urlToVideo!)?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
