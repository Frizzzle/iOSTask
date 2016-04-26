//
//  NetworkManager.swift
//  iOSTask
//
//  Created by Koctya Bondar on 23.04.16.
//  Copyright © 2016 Koctya Bondar. All rights reserved.
//

import UIKit
import Alamofire



class NetworkManager {
    static let sharedInstance = NetworkManager()
    
    init() {
    
        Alamofire.request(.GET, SERVER_URL).responseJSON { (response) in
            CoreDataManager.sharedInstance.loadState = ST_NOT_LOADED
            if let JSON = response.result.value {
                if let feed = (JSON["feed"] as? NSMutableDictionary) {
                    for entry in feed["entry"] as! NSArray {
                        print(entry)
                        let news = NewsModel(id: (((entry["id"] as! NSMutableDictionary)["attributes"] as! NSMutableDictionary)["im:id"] as! String),
                            artist: ((entry["im:artist"] as! NSMutableDictionary)["label"] as! String),
                            title: ((entry["title"] as! NSMutableDictionary)["label"] as! String),
                            name: ((entry["im:name"] as! NSMutableDictionary)["label"] as! String),
                            releaseDate: (((entry["im:releaseDate"] as! NSMutableDictionary)["attributes"] as! NSMutableDictionary)["label"] as! String),
                            price: ((entry["im:price"] as! NSMutableDictionary)["label"] as! String),
                            rights: ((entry["rights"] as! NSMutableDictionary)["label"] as! String),
                            imageURL60: (((entry["im:image"] as! NSArray)[1] as! NSMutableDictionary)["label"] as! String),
                            imageURL170: (((entry["im:image"] as! NSArray)[2] as! NSMutableDictionary)["label"] as! String))
                        CoreDataManager.sharedInstance.newsCollection.append(news)
                    }
                    CoreDataManager.sharedInstance.loadState = ST_LOADED
                    NSNotificationCenter.defaultCenter().postNotificationName("NewsLoaded", object: nil);
                }
                print();
            }
        }
    }

}
