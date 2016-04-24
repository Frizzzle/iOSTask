//
//  NewsVC.swift
//  iOSTask
//
//  Created by Koctya Bondar on 23.04.16.
//  Copyright © 2016 Koctya Bondar. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {
    var selectedNews:Int!
    override func viewDidLoad() {
        
        let background = UIImage(named: "background")
        NetworkManager.sharedInstance;
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        

        
    }
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(newsAreLoaded),
            name: "NewsLoaded",
            object: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    @IBOutlet weak var tableView: UITableView!
    func newsAreLoaded() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let detailVC = segue.destinationViewController as! NewsDetailVC
        let selected = CoreDataManager.sharedInstance.newsCollection[selectedNews]
        detailVC.name = selected.name
        detailVC.titleAlbom = selected.title
        detailVC.artist = selected.artist
        detailVC.releaseDate = selected.releaseDate
        detailVC.price = selected.price
        detailVC.rights = selected.rights

    }

}
extension NewsVC : UITableViewDataSource {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        selectedNews = indexPath.row
        self.performSegueWithIdentifier(SEGUE_DETAIL, sender: self);
        

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.sharedInstance.newsCollection.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCellWithIdentifier(TVC_NEWS) as! NewsTVC;
        newsCell.newsTitle.text = CoreDataManager.sharedInstance.newsCollection[indexPath.row].title;
        newsCell.newsDate.text = CoreDataManager.sharedInstance.newsCollection[indexPath.row].releaseDate;
        newsCell.newsFavLabel.text = "Add to favorite"
        
        return newsCell;
    }
}


extension NewsVC : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}