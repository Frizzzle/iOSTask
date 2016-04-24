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
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let detailVC = segue.destinationViewController as! NewsDetailVC
        detailVC.name = "Test NAME"
        detailVC.titleAlbom = "Some test title"
        detailVC.artist = "Artist - Some artist"
        detailVC.releaseDate = "Release date - 25.58.4834"
        detailVC.price = "Price - 25$"
        detailVC.rights = "Some rights"
    }

}
extension NewsVC : UITableViewDataSource {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        self.performSegueWithIdentifier(SEGUE_DETAIL, sender: self);

    }
    
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