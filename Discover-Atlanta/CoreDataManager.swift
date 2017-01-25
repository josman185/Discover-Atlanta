//
//  CoreDataManager.swift
//  Discover-Atlanta
//
//  Created by jos on 11/1/16.
//  Copyright © 2016 myOrganization. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    // Save Data
    class func saveFavoritePlace(name:String, address:String, imageURL:String, latitude:String, longitude:String, urlToVideo: String, webUrl: String, description:String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoritePlaces", in: managedContext)
        let place = NSManagedObject(entity: entity!, insertInto: managedContext)
        place.setValue(name, forKey: "name")
        place.setValue(address, forKey: "address")
        place.setValue(imageURL, forKey: "imageURL")
        place.setValue(latitude, forKey: "latitude")
        place.setValue(longitude, forKey: "longitude")
        place.setValue(urlToVideo, forKey: "urlToVideo")
        place.setValue(webUrl, forKey: "webUrl")
        place.setValue(description, forKey: "descriptionPlace")
        do{
            try managedContext.save()
            print("Fovorite Place Saved succesfully")
        }catch{
            print("could not save Fovorite New")
        }
    }
    
    // Getting Data
    class func getFavoritePlaces() -> [Place] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoritePlaces")
        //var output: [(String,String,String)] = []
        var output: [Place] = []
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            let favoritePlaces = results as! [NSManagedObject]
            
            for place in favoritePlaces {
                guard let placeName = place.value(forKey: "name") as? String else { continue }
                guard let placeAddress = place.value(forKey: "address") as? String else { continue }
                guard let placeImageURL = place.value(forKey: "imageURL") as? String else { continue }
                guard let placeLat = place.value(forKey: "latitude") as? String else { continue }
                guard let placeLon = place.value(forKey: "longitude") as? String else { continue }
                guard let placeUrlToVideo = place.value(forKey: "urlToVideo") as? String else { continue }
                guard let placeWebUrl = place.value(forKey: "webUrl") as? String else { continue }
                guard let placeDesc = place.value(forKey: "descriptionPlace") as? String else { continue }
                //output.append((placeName,placeAddress, placeImageURL))
                let newplace = Place(name: placeName, latitude: placeLat, longitude: placeLon, url: placeWebUrl, urlToImage: placeImageURL, address: placeAddress, description: placeDesc, urlToVideo: placeUrlToVideo)
                output.append(newplace)
            }
            
        }catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return output
    }
    
    // Delete Data
    class func deleteFavoritePlace(Name: String, address: String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchPredicate = NSPredicate(format: "name=%@ and address=%@", argumentArray: [Name, address])
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoritePlaces")
        fetchRequest.predicate = fetchPredicate
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            let places = results as! [NSManagedObject]
            
            for place in places {
                managedContext.delete(place)
            }
            try managedContext.save()
        }catch{
            print("Could not find place \(Name) \(address)")
        }
    }
}
