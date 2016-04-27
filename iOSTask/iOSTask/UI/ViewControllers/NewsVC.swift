//
//  NewsVC.swift
//  iOSTask
//
//  Created by Koctya Bondar on 23.04.16.
//  Copyright © 2016 Koctya Bondar. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class NewsVC: UIViewController {
    var selectedNews:Int!
    override func viewDidLoad() {
        NetworkManager.sharedInstance;
        let background = UIImage(named: "background")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        self.title = "News"
    }
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(newsAreLoaded),
            name: "NewsLoaded",
            object: nil)
        self.tableView.reloadData()
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
        detailVC.news = selected
    }
    
    func changStateFavorite(gestureRecognizer: UIGestureRecognizer) {
        let index = gestureRecognizer.view?.tag
        let element = CoreDataManager.sharedInstance.newsCollection[index!]
        //CoreDataManager.sharedInstance.addToFavorite()
        let indexPath = NSIndexPath(forRow: index!, inSection: 0)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! NewsTVC
        if(CoreDataManager.sharedInstance.checkInFavorite(element)) {
            cell.newsFavLabel.text = "Add to favorite"
            cell.newsFavoriteImage.image = UIImage(named: IMG_WHITE_HEART)
            CoreDataManager.sharedInstance.removeFromFavorite(element)
        }else {
            cell.newsFavLabel.text = "Remove from favorite"
            cell.newsFavoriteImage.image = UIImage(named: IMG_WHITE_HEART_UN_HOLO)
            CoreDataManager.sharedInstance.addToFavorite(element)
        }
    }
}
extension NewsVC : UITableViewDataSource {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        
        selectedNews = indexPath.row
        self.performSegueWithIdentifier(SEGUE_DETAIL, sender: self)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.sharedInstance.newsCollection.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCellWithIdentifier(TVC_NEWS) as! NewsTVC;
        newsCell.newsTitle.text = CoreDataManager.sharedInstance.newsCollection[indexPath.row].title;
        newsCell.newsDate.text = CoreDataManager.sharedInstance.newsCollection[indexPath.row].releaseDate;
        if(CoreDataManager.sharedInstance.checkInFavorite(CoreDataManager.sharedInstance.newsCollection[indexPath.row].id)) {
            newsCell.newsFavLabel.text = "Remove from favorite"
            newsCell.newsFavoriteImage.image = UIImage(named: IMG_WHITE_HEART_UN_HOLO)
        }else {
            newsCell.newsFavLabel.text = "Add to favorite"
            newsCell.newsFavoriteImage.image = UIImage(named: IMG_WHITE_HEART)
        }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(NewsVC.changStateFavorite(_:)))
        newsCell.newsFavoriteImage.addGestureRecognizer(recognizer)
        newsCell.newsFavoriteImage.userInteractionEnabled = true
        newsCell.newsFavoriteImage.tag = indexPath.row
        newsCell.newsFavoriteImage.hidden = false;
        
        let url = NSURL(string: CoreDataManager.sharedInstance.newsCollection[indexPath.row].imageURL60!)
        newsCell.newsImage.af_setImageWithURL(url!)
        newsCell.newsImage.layer.cornerRadius = 5
        newsCell.newsImage.clipsToBounds = true
       
        
        return newsCell;
    }
}


extension NewsVC : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}