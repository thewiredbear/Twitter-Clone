//
//  DetailViewController.swift
//  TwitterDemo
//
//  Created by Parth Bhardwaj on 3/6/16.
//  Copyright © 2016 Parth Bhardwaj. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    //@IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
//    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
//    @IBOutlet weak var userNameHandle: UILabel!
    @IBOutlet weak var userNameHandle: UILabel!
//    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
//    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
//    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
//    
//    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
//    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    
    
    
    var tweetID: String = ""
    
    var tweet: Tweet!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = tweet.user?.name as? String
        userNameHandle.text = tweet.user?.screenname as? String
        tweetTextLabel.text = tweet.text as? String
        
        let imageURL = tweet.user?.profileURL!
        profilePictureImageView.setImageWithURL(imageURL!)
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d"
        dateLabel.text = formatter.stringFromDate(tweet.timestamp!)
        
        retweetLabel.text = String(tweet.retweetCount)
        favoriteLabel.text = String(tweet.favorites_count)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLike(sender: AnyObject) {
        if(tweet.favorited == false){
            favoriteLabel.text = String(tweet.favorites_count + 1)
            //self.favoriteButton.setImage(UIImage(named: "favoriteED"), forState: UIControlState.Selected)
            tweet.favorited=true
        }
        else if(tweet.favorited == true){
            favoriteLabel.text = String (tweet.favorites_count)
            //elf.favoriteButton.setImage(UIImage(named: "no_favorite" ), forState: UIControlState.Selected)
            tweet.favorited=false
        }
    }

    @IBAction func onRetweet(sender: AnyObject) {
        if(tweet.retweeted == false){
            retweetLabel.text = String(tweet.retweetCount + 1)
            //self.retweetButton.setImage(UIImage(named: "retweetED"), forState: UIControlState.Selected)
            tweet.retweeted=true
        }else if(tweet.retweeted == true){
            retweetLabel.text = String(tweet.retweetCount)
            //self.retweetButton.setImage(UIImage(named: "no_retweet"), forState: UIControlState.Selected)
            tweet.retweeted=false
        }
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
