//
//  NewsDetailVC.swift
//  iOSTask
//
//  Created by Koctya Bondar on 24.04.16.
//  Copyright © 2016 Koctya Bondar. All rights reserved.
//

import UIKit
import Social
import AlamofireImage
import MessageUI

class NewsDetailVC: UIViewController,MFMailComposeViewControllerDelegate {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var rightsLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var artistLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imageAlbom: UIImageView!
    
    @IBOutlet weak var emSharingBtn: UIButton!
    @IBOutlet weak var twSharingBtn: UIButton!
    @IBOutlet weak var fbSharingBtn: UIButton!
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
        imageAlbom.af_setImageWithURL(NSURL(string:news.imageURL170!)!)
        
        imageAlbom.layer.cornerRadius = 5
        imageAlbom.clipsToBounds = true
        fbSharingBtn.layer.cornerRadius = 10
        fbSharingBtn.clipsToBounds = true
        twSharingBtn.layer.cornerRadius = 10
        twSharingBtn.clipsToBounds = true
        emSharingBtn.layer.cornerRadius = 10
        emSharingBtn.clipsToBounds = true
    }
    @IBAction func fbSharingAction(sender: AnyObject) {
        let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        vc.setInitialText(news.title)
        vc.addImage(imageAlbom.image!)
        vc.addURL(NSURL(string: news.link))
        presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func twSharingAction(sender: AnyObject) {
        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        vc.setInitialText(news.title)
        vc.addImage(imageAlbom.image!)
        vc.addURL(NSURL(string: news.link))
        presentViewController(vc, animated: true, completion: nil)
    }
    @IBAction func emSharingAction(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        mailComposerVC.setSubject("I like it - " + news.title)
        mailComposerVC.setMessageBody(news.title + "\n" + news.artist + "\n" + news.releaseDate, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        //let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        //sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
