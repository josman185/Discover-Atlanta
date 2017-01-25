//
//  MapViewTabBarViewController.swift
//  Discover-Atlanta
//
//  Created by jos on 11/1/16.
//  Copyright © 2016 myOrganization. All rights reserved.
//

import UIKit
import MapKit

class MapViewTabBarViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var myMapView: MKMapView!
    var locationManager: CLLocationManager?
    var coordinatesArray: [AnnotationsTabBar] = []
    var allPlacesArray:[Place]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // getting all the places
        
        let places = Place.downLoadAllPlaces()
        for place in places {
            let annotations = AnnotationsTabBar(title: place.name!, address: place.address!, coordinate: CLLocationCoordinate2D(latitude: Double(place.latitude!)!, longitude: Double(place.longitude!)!))
            coordinatesArray.append(annotations)
        }
        myMapView.addAnnotations(coordinatesArray)
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
        myMapView.showsUserLocation = true
        
        if let lastLocation = locationManager?.location {
            
            //center Map View
            let center = CLLocationCoordinate2DMake(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
            
            myMapView.setCenter(center, animated: true)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
            
            let region = MKCoordinateRegionMake(center, span)
            
            myMapView.setRegion(region, animated: true)

        }

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

class AnnotationsTabBar: NSObject, MKAnnotation {
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
