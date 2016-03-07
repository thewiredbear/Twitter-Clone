//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Parth Bhardwaj on 3/6/16.
//  Copyright © 2016 Parth Bhardwaj. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
//    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
//    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
//    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
//    @IBOutlet weak var userNameHandleLabel: UILabel!
    @IBOutlet weak var userNameHandleLabel: UILabel!
//    @IBOutlet weak var tweetsToatlLabel: UILabel!
    @IBOutlet weak var tweetsTotalLabel: UILabel!
//    @IBOutlet weak var followingTotalLabel: UILabel!
    @IBOutlet weak var followingTotalLabel: UILabel!
//    @IBOutlet weak var followersTotalLabel: UILabel!
    @IBOutlet weak var followersTotalLabel: UILabel!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let imageUrl = user?.profileURL
        profilePictureImageView.setImageWithURL(imageUrl!)
        
        
        
        //let banner = (user?.bannerImageUrl!)!
        bannerImageView.setImageWithURL((user?.bannerImageURL)!)
        
        
        userNameLabel.text = user?.name as? String
        userNameHandleLabel.text = "@\((user?.screenname)!)"
        tweetsTotalLabel.text = String(user!.statusesCount)
        followingTotalLabel.text = String(user!.followingTotal)
        followersTotalLabel.text = String(user!.followersTotal)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
