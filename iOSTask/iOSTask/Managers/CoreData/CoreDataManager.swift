//
//  CoreDataManager.swift
//  iOSTask
//
//  Created by Koctya Bondar on 23.04.16.
//  Copyright © 2016 Koctya Bondar. All rights reserved.
//

import UIKit
import CoreData 

class CoreDataManager {
    var loadState:Int!
    let appDelegate:AppDelegate!
    let managedContext:NSManagedObjectContext!
    static let sharedInstance = CoreDataManager()
    var newsCollection:[NewsModel!]
    var favoriteCollection:[NewsModel!]
    init() {
        self.newsCollection = [NewsModel]()
        self.favoriteCollection = [NewsModel]()
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedContext = appDelegate.managedObjectContext
        loadState = ST_NOT_LOADED
        self.loadFavoriteFromLocal()
    }
    
    func checkInFavorite(element:NewsModel) -> Bool{
        let checkID = element.id
        for favoriteElement in favoriteCollection {
            if(checkID == favoriteElement.id) {
                return true
            }
        }
        return false
    }
    
    func checkInFavorite(id:String) -> Bool{
        for favoriteElement in favoriteCollection {
            if(id == favoriteElement.id) {
                return true
            }
        }
        return false
    }
    
    func removeFromFavorite(element:NewsModel) {
        if(!checkInFavorite(element)) {
            return
        }
        managedContext.performBlock {
            let createRequest = NSFetchRequest(entityName: ENT_NEWS)
            let predicate = NSPredicate(format: "id = %@", element.id)
            createRequest.predicate = predicate
            do {
                let result = try self.managedContext.executeFetchRequest(createRequest)
                if (result.count == 1) {
                    self.managedContext.deleteObject((result[0] as! NSManagedObject))
                    try self.managedContext.save()
                    self.favoriteCollection.removeObject(element)
                }
            }catch {
                
            }
            
        }
        
    }
    
    func addToFavorite(newElement:NewsModel) {
        if(checkInFavorite(newElement)) {
            return
        }
        let entity =  NSEntityDescription.entityForName(ENT_NEWS,
                                                        inManagedObjectContext:
            managedContext)
        let news = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        news.setValue(newElement.id, forKey: ATT_NEWS_ID)
        news.setValue(newElement.artist, forKey: ATT_NEWS_ARTIST)
        news.setValue(newElement.name, forKey: ATT_NEWS_NAME)
        news.setValue(newElement.title, forKey: ATT_NEWS_TITLE)
        news.setValue(newElement.releaseDate, forKey: ATT_NEWS_RELEASEDATE)
        news.setValue(newElement.rights, forKey: ATT_NEWS_RIGHTS)
        news.setValue(newElement.imageURL60, forKey: ATT_NEWS_IMAGEURL60)
        news.setValue(newElement.imageURL170, forKey: ATT_NEWS_IMAGEURL170)
        news.setValue(newElement.price, forKey: ATT_NEWS_PRICE)
        do {
            try managedContext.save()
            favoriteCollection.append(newElement)
        }catch {
             fatalError("Failure to save context: \(error)")
        }
    }
    
    func loadFavoriteFromLocal(){
        let fetchRequest = NSFetchRequest(entityName: ENT_NEWS)
        //let fetchedResults:[NSManagedObject]
        do {
            let  fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            if let resultNews = fetchedResults {
                for newsElement in resultNews {
                    let id = newsElement.valueForKey(ATT_NEWS_ID) as! String
                    let artist = newsElement.valueForKey(ATT_NEWS_ARTIST) as! String
                    let title = newsElement.valueForKey(ATT_NEWS_TITLE) as! String
                    let name = newsElement.valueForKey(ATT_NEWS_NAME) as! String
                    let releaseDate = newsElement.valueForKey(ATT_NEWS_RELEASEDATE) as! String
                    let price = newsElement.valueForKey(ATT_NEWS_PRICE) as! String
                    let rights = newsElement.valueForKey(ATT_NEWS_RIGHTS) as! String
                    let imageURL60 = newsElement.valueForKey(ATT_NEWS_IMAGEURL60) as! String
                    let imageURL170 = newsElement.valueForKey(ATT_NEWS_IMAGEURL170) as! String
                    
                    let element = NewsModel(id: id, artist: artist, title: title, name: name, releaseDate: releaseDate, price: price, rights: rights, imageURL60: imageURL60, imageURL170: imageURL170)
                    self.favoriteCollection.append(element)
                }
                loadState = ST_LOADED
            }else {
                print("The newsStore is empty")
            }
        }catch {
            
        }

    }
}
extension Array {
    mutating func removeObject<U: Equatable>(object: U) -> Bool {
        for (idx, objectToCompare) in self.enumerate() {  //in old swift use enumerate(self)
            if let to = objectToCompare as? U {
                if object == to {
                    self.removeAtIndex(idx)
                    return true
                }
            }
        }
        return false
    }
}
