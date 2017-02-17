//
//  MainTableVC.swift
//  Discover-Atlanta
//
//  Created by jos on 10/26/16.
//  Copyright © 2016 myOrganization. All rights reserved.  
//

import UIKit

class ImageDownloader {
    
    class func withURL(_ url:String?) -> UIImage! {
        var myImage:UIImage? = nil
        if (url != nil){
            let data = try? Data(contentsOf: URL(string: url!)!)
            myImage = UIImage(data: data!)
        }else{
            myImage = UIImage(named: "not_found-1.jpg")
        }
        return myImage
    }
}

class MainTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var placesArray = [Place]()
    var filteredPlacesArray = [Place]()
    
    let searchController = UISearchController(searchResultsController: nil) // searchBar
    
    @IBOutlet weak var maintableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make dynamic table
        maintableView.rowHeight = UITableViewAutomaticDimension
        maintableView.estimatedRowHeight = 140
        
        // SearchBar Config
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        maintableView.tableHeaderView = searchController.searchBar
        
        placesArray = Place.downLoadAllPlaces()
    }
    
    // SearchBar - helper method
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredPlacesArray = placesArray.filter { place in
            return (place.name?.lowercased().contains(searchText.lowercased()))!
        }
        
        maintableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //tableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredPlacesArray.count
        }
        return placesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMainTableID", for: indexPath) as! CustomCell_MainTable
        
        let place: Place
        if searchController.isActive && searchController.searchBar.text != "" {
            place = filteredPlacesArray[indexPath.row]
        }else {
            place = placesArray[indexPath.row]
        }
        
        cell.nameLbl.text = place.name!
        cell.addressLbl.text = place.address!
        cell.descriptionLbl.text = place.shortDesc!
        if place.urlToImage != nil {
            DispatchQueue.global(qos: .userInitiated).async{
                let img = ImageDownloader.withURL(place.urlToImage)
                DispatchQueue.main.async{
                    cell.imageLBl.image = img
                }
            }
        }else {
            cell.imageLBl.image = UIImage(named: "not_found-1.jpg")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    //NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToTableDetail" {
            if let indexPath = maintableView.indexPathForSelectedRow {
                
                let place: Place
                if searchController.isActive && searchController.searchBar.text != "" {
                    place = filteredPlacesArray[indexPath.row]
                }else {
                    place = placesArray[indexPath.row]
                }
                
                let newsDetalVC = segue.destination as! DetailMainTableVC
                newsDetalVC.rowInfo = place
            }
        }
    }
    
    //MARK:- Addign slide Favorite button
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // button declaration
        let favoriteButton = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
            let place = self.placesArray[(indexPath as NSIndexPath).row]
            let placeName = place.name!
            let placeAddress = place.address!
            let placeImageUrl = place.urlToImage!
            let placeLatitude = place.latitude!
            let placeLongitude = place.longitude!
            let placeUrlToVideo = place.urlToVideo!
            let placewebUrl = place.url!
            let placeDesc = place.description!
            let placeShortDesc = place.shortDesc!
            
         // check if element exist
            
            let eleExist = CoreDataManager.checkIfExist(Name: placeName, address: placeAddress)
            if eleExist {
                print("element already exist")
                
            }else {
                // #selector
                self.AddToFavorite(name: placeName, address: placeAddress, imageUrl: placeImageUrl, latitude: placeLatitude, longitude: placeLongitude, urlToVideo: placeUrlToVideo, webUrl: placewebUrl, description: placeDesc, shortDesc: placeShortDesc)
            }
        }
        favoriteButton.backgroundColor = UIColor.orange
        return [favoriteButton]
    }
    
    // favorite's button #selector
    func AddToFavorite(name: String, address: String, imageUrl: String, latitude: String, longitude: String, urlToVideo: String, webUrl: String, description: String, shortDesc: String){
        
        CoreDataManager.saveFavoritePlace(name: name, address: address, imageURL: imageUrl, latitude: latitude, longitude: longitude, urlToVideo: urlToVideo, webUrl: webUrl, description: description, shortDesc: shortDesc)
        maintableView.reloadData()
    }
}

// SearchBar Extension
extension MainTableVC: UISearchResultsUpdating {
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
