//
//  ParseFile.swift
//  Discover-Atlanta
//
//  Created by jos on 10/26/16.
//  Copyright © 2016 myOrganization. All rights reserved.
//

import Foundation

class ParseFile {
    
    static func parsingJsonFromData(jsonData: NSData?) -> [String : AnyObject]? {
        if let data = jsonData {
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject]
                return jsonDictionary
            } catch let error as NSError {
                print("\(error.localizedDescription)")
            }
        }
     return nil
    }
}
