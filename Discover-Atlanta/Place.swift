//
//  Place.swift
//  Discover-Atlanta
//
//  Created by jos on 10/26/16.
//  Copyright © 2016 myOrganization. All rights reserved.
//

import Foundation

class Place {
    var name, latitude, longitude, url, urlToImage, address, shortDesc, description, urlToVideo: String?
    
    init(name: String?, latitude: String?, longitude: String?, url: String?, urlToImage: String?, address: String?, shortDesc: String? ,description: String?, urlToVideo: String?) {
        self.name = name!
        self.latitude = latitude!
        self.longitude = longitude!
        self.url = url!
        self.urlToImage = urlToImage!
        self.address = address!
        self.shortDesc = shortDesc!
        self.description = description!
        self.urlToVideo = urlToVideo!
    }
    
    init(jsonDictionary: [String:AnyObject]){
        self.name = jsonDictionary["name"] as? String
        self.latitude = jsonDictionary["latitude"] as? String
        self.longitude = jsonDictionary["longitude"] as? String
        self.url = jsonDictionary["url"] as? String
        self.urlToImage = jsonDictionary["urlToImage"] as? String
        self.address = jsonDictionary["address"] as? String
        self.shortDesc = jsonDictionary["shortDesc"] as? String
        self.description = jsonDictionary["description"] as? String
        self.urlToVideo = jsonDictionary["urlToVideo"] as? String
    }
    
    static func downLoadAllPlaces() -> [Place] {
        var places = [Place]()
        
        let jsonFile = Bundle.main.path(forResource: "dataSource", ofType: "json")
        
        let jsonData = NSData(contentsOfFile: jsonFile!)
        
        if let jsonDictionary = ParseFile.parsingJsonFromData(jsonData: jsonData) {
            let placeDictionaries = jsonDictionary["places"] as! [[String:AnyObject]]
            
            for place in placeDictionaries {
                let newPlace = Place(jsonDictionary: place)
                places.append(newPlace)
            }
        }
        
        return places
    }

}
