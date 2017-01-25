//
//  MapViewController.swift
//  Discover-Atlanta
//
//  Created by jos on 10/29/16.
//  Copyright © 2016 myOrganization. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var rowInfo : Place?
    
    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var addressLbl: UILabel!
    
    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = rowInfo?.name
        addressLbl.text = rowInfo?.address
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
        myMapView.showsUserLocation = true
        
        //center Map View
        let lat = ((Double((rowInfo?.latitude)!)! as CLLocationDegrees))
        let long = ((Double((rowInfo?.longitude)!)! as CLLocationDegrees))
        let center = CLLocationCoordinate2DMake(lat, long)
        
        myMapView.setCenter(center, animated: true)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.120, longitudeDelta: 0.120 )
        
        let region = MKCoordinateRegionMake(center, span)
        
        myMapView.setRegion(region, animated: true)
        
        //add and create annotation
        let annotation = MapAnnotation(title: (rowInfo?.name)!, address: (rowInfo?.address)!, coordinate: CLLocationCoordinate2DMake(lat, long))
        
        myMapView.addAnnotation(annotation)
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

class MapAnnotation: NSObject, MKAnnotation {
    let title: String?
    let address: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, address: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.address = address
        self.coordinate = coordinate
        
        super.init()
    }
}
