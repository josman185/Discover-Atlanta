//
//  CustomCell-MainTable.swift
//  Discover-Atlanta
//
//  Created by jos on 10/27/16.
//  Copyright © 2016 myOrganization. All rights reserved.
//

import UIKit

class CustomCell_MainTable: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var imageLBl: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
