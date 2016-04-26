//
//  FavoriteVC.swift
//  iOSTask
//
//  Created by Koctya Bondar on 23.04.16.
//  Copyright © 2016 Koctya Bondar. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {
    var selectedNews:Int!
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
    
    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData();
    }
    
    func removeFromFavorite(gestureRecognizer: UIGestureRecognizer) {
        let selectedNewsToFavorite = gestureRecognizer.view?.tag
        gestureRecognizer.view?.removeGestureRecognizer(gestureRecognizer)
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),{
            CoreDataManager.sharedInstance.removeFromFavorite(CoreDataManager.sharedInstance.favoriteCollection[selectedNewsToFavorite!])
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.reloadData()
                });
            });
        
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let detailVC = segue.destinationViewController as! NewsDetailVC
        let selected = CoreDataManager.sharedInstance.favoriteCollection[selectedNews]
        detailVC.news = selected
    }
    

}
extension FavoriteVC : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.sharedInstance.favoriteCollection.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCellWithIdentifier(TVC_NEWS) as! NewsTVC;
        newsCell.newsTitle.text = CoreDataManager.sharedInstance.favoriteCollection[indexPath.row].title;
        newsCell.newsFavLabel.text = "Remove from favorite"
        newsCell.newsFavoriteImage.image = UIImage(named: IMG_WHITE_HEART_UN_HOLO)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(FavoriteVC.removeFromFavorite(_:)))
        newsCell.newsFavoriteImage.addGestureRecognizer(recognizer)
        newsCell.newsFavoriteImage.userInteractionEnabled = true
        newsCell.newsFavoriteImage.tag = indexPath.row
        newsCell.newsFavoriteImage.hidden = false;
        
        let url = NSURL(string: CoreDataManager.sharedInstance.favoriteCollection[indexPath.row].imageURL60)
        newsCell.newsImage.af_setImageWithURL(url!)
        
        return newsCell;
    }
}

extension FavoriteVC : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedNews = indexPath.row
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier(SEGUE_DETAIL, sender: self)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}