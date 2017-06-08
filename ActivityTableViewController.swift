//
//  ActivityTableViewController.swift
//  iXLocation
//
//  Created by Ricky Humbert on 6/7/17.
//  Copyright © 2017 Ricky Humbert. All rights reserved.
//

import UIKit
import Alamofire
import Gloss

class ActivityTableViewController: UITableViewController {
    
    var activities: [Activity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("https://ixlocation.firebaseio.com/activities.json").responseJSON { response in
            //print(response.request)  // original URL request
            //print(response.response) // HTTP URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                let response = JSON as! NSDictionary
                
                for (key, value) in response {
                    let activity = Activity()
                    
                    if let actDictionary = value as? [String : AnyObject] {
                        activity?.name = actDictionary["name"] as! String
                        activity?.description = actDictionary["description"] as! String
                        
                        if let geoPointDictionary = actDictionary["location"] as? [String: AnyObject] {
                            let location = GeoPoint()
                            location.lat = geoPointDictionary["lat"] as? Double
                            location.lng = geoPointDictionary["lng"] as? Double
                            activity?.location = location
                        }
                    }
                    
                    self.activities.append(activity!)
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = activities[indexPath.item].name
        cell.detailTextLabel?.text = activities[indexPath.item].description
        
        return cell
    }
    
    
}
