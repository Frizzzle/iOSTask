//
//  NewsVC.swift
//  iOSTask
//
//  Created by Koctya Bondar on 23.04.16.
//  Copyright © 2016 Koctya Bondar. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {
    override func viewDidLoad() {
        let background = UIImage(named: "background")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
    }

}
extension NewsVC : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCellWithIdentifier(TVC_NEWS) as! NewsTVC;
        newsCell.newsTitle.text = "Test Title for news"
        newsCell.newsDate.text = "15.19.2087"
        newsCell.newsFavLabel.text = "Add to favorite"
        
        return newsCell;
    }
}

extension NewsVC : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}