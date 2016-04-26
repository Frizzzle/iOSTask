//
//  FavoriteVC.swift
//  iOSTask
//
//  Created by Koctya Bondar on 23.04.16.
//  Copyright © 2016 Koctya Bondar. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {
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
        CoreDataManager.sharedInstance.addToFavorite(CoreDataManager.sharedInstance.newsCollection[selectedNewsToFavorite!])
        print("tap")
    }
    

}
extension FavoriteVC : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.sharedInstance.favoriteCollection.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCellWithIdentifier(TVC_NEWS) as! NewsTVC;
        newsCell.newsTitle.text = CoreDataManager.sharedInstance.favoriteCollection[indexPath.row].title;
        //newsCell.newsDate.text = CoreDataManager.sharedInstance.favoriteCollection[indexPath.row].releaseDate;
        newsCell.newsFavLabel.text = "Remove from favorite"
        newsCell.newsFavoriteImage.image = UIImage(named: IMG_WHITE_HEART_UN_HOLO)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(FavoriteVC.removeFromFavorite(_:)))
        newsCell.newsFavoriteImage.addGestureRecognizer(recognizer)
        newsCell.newsFavoriteImage.userInteractionEnabled = true
        newsCell.newsFavoriteImage.tag = indexPath.row
        newsCell.newsFavoriteImage.hidden = false;
        return newsCell;
    }
}

extension FavoriteVC : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}