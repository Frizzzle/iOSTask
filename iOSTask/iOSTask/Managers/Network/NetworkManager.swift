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
                        let idDict = (entry["id"] as! NSMutableDictionary)
                        let artistDict = (entry["im:artist"] as? NSMutableDictionary)
                        let titleDict = (entry["title"] as? NSMutableDictionary)
                        let nameDict = (entry["im:name"] as? NSMutableDictionary)
                        let releaseDict = (entry["im:releaseDate"] as? NSMutableDictionary)
                        let priceDict = (entry["im:price"] as? NSMutableDictionary)
                        let rightsDict = (entry["rights"] as? NSMutableDictionary)
                        let imgDict = (entry["im:image"] as? NSArray)
                        let linkDict = (entry["link"] as? NSArray)
                        let news = NewsModel(id: ((idDict ["attributes"] as! NSMutableDictionary)["im:id"] as! String),
                            artist: artistDict != nil ? (artistDict!["label"] as! String):" ",
                            title: titleDict != nil ? (titleDict!["label"] as! String):" ",
                            name: nameDict != nil ? (nameDict!["label"] as! String):" ",
                            releaseDate: releaseDict != nil ? ((releaseDict!["attributes"] as! NSMutableDictionary)["label"] as! String):" ",
                            price: priceDict != nil ? (priceDict!["label"] as! String):" ",
                            rights: rightsDict != nil ? (rightsDict!["label"] as! String):" ",
                            imageURL60: imgDict != nil ? ((imgDict![1] as! NSMutableDictionary)["label"] as! String):" ",
                            imageURL170: imgDict != nil ? ((imgDict![2] as! NSMutableDictionary)["label"] as! String):" ",
                            link: linkDict != nil ? (((linkDict![0] as! NSMutableDictionary)["attributes"] as! NSMutableDictionary)["href"] as! String):" ")
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
