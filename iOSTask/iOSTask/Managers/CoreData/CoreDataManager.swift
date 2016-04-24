//
//  CoreDataManager.swift
//  iOSTask
//
//  Created by Koctya Bondar on 23.04.16.
//  Copyright © 2016 Koctya Bondar. All rights reserved.
//

import UIKit

class CoreDataManager {
    var loadState:Int!
    static let sharedInstance = CoreDataManager()
    var newsCollection:[NewsModel!]
    init() {
        loadState = ST_NOT_LOADED
        self.newsCollection = [NewsModel]()
    }
}
