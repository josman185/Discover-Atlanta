//
//  FavoritesViewController.swift
//  Discover-Atlanta
//
//  Created by jos on 11/1/16.
//  Copyright © 2016 myOrganization. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var favoritePlacesArray : [Place] = []
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem?.action = #selector(showingDeleteButtons)
        updateFavoritePlacesTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateFavoritePlacesTable(){
        favoritePlacesArray.removeAll()
        let favoritePlaces = CoreDataManager.getFavoritePlaces()
        for place in favoritePlaces {
            favoritePlacesArray.append(place)
        }
        favoritesTableView.reloadData()
    }
    
    //MARK:- TableView Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePlacesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "favoritesCellid", for: indexPath) as! CustomCell_Favorites
        
        let place = favoritePlacesArray[(indexPath as NSIndexPath).row]
        
        cell.nameLbl.text = place.name
        cell.addressLbl.text = place.address
        cell.imageLbl.image = ImageDownloader.withURL(place.urlToImage)
        
        return cell
    }
    
    // update table before presenting to user
    override func viewWillAppear(_ animated: Bool) {
        updateFavoritePlacesTable()
    }
    
    //MARK:- Deleting rows
    func showingDeleteButtons(){
        if (!favoritesTableView.isEditing){
            favoritesTableView.setEditing(true, animated: true)
        }else{
            favoritesTableView.setEditing(false, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let place = favoritePlacesArray[indexPath.row]
            CoreDataManager.deleteFavoritePlace(Name: place.name!, address: place.address!)
            
            favoritePlacesArray.remove(at: indexPath.row)
            favoritesTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromFavoritesToDetail" {
            let newsDetalVC = segue.destination as! DetailMainTableVC
            let row = (self.favoritesTableView.indexPathForSelectedRow! as NSIndexPath).row
            let rowInfo = favoritePlacesArray[row]
            newsDetalVC.rowInfo = rowInfo
        }
    }
    

}
