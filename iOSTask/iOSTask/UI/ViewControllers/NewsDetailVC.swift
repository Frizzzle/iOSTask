//
//  NewsDetailVC.swift
//  iOSTask
//
//  Created by Koctya Bondar on 24.04.16.
//  Copyright © 2016 Koctya Bondar. All rights reserved.
//

import UIKit

class NewsDetailVC: UIViewController {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var rightsLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var artistLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imageAlbom: UIImageView!
    
    var news:NewsModel!
    
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
        
        nameLbl.text = news.name;
        priceLbl.text = news.price;
        rightsLbl.text = news.rights;
        releaseDateLbl.text = news.releaseDate;
        artistLbl.text = news.artist;
        titleLbl.text = news.title;
        imageAlbom.af_setImageWithURL(NSURL(string:news.imageURL170)!)
    }
    
}
