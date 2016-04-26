//
//  NewsModel.swift
//  iOSTask
//
//  Created by Koctya Bondar on 24.04.16.
//  Copyright © 2016 Koctya Bondar. All rights reserved.
//

class NewsModel:Equatable {
    var id:String!
    var artist:String!
    var title:String!
    var name:String!
    var releaseDate:String!
    var price:String!
    var rights:String!
    var imageURL60:String!
    var imageURL170:String!
    

    
    init(id:String,artist:String,title:String,name:String,releaseDate:String,price:String,rights:String,imageURL60:String,imageURL170:String) {
        self.id = id
        self.artist = artist
        self.title = title
        self.name = name
        self.releaseDate = releaseDate
        self.price = price
        self.rights = rights
        self.imageURL60 = imageURL60
        self.imageURL170 = imageURL170
    }

    
}
func == (lhs: NewsModel, rhs: NewsModel) -> Bool {
    return lhs.id == rhs.id
}

