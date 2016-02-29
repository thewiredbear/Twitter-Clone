//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Parth Bhardwaj on 2/27/16.
//  Copyright © 2016 Parth Bhardwaj. All rights reserved.
//

import UIKit


class TweetCell: UITableViewCell {
    var tweet: Tweet?
    var retweeted = false
    var favorited = false
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoritesCount: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userNameLabel.preferredMaxLayoutWidth = userNameLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userNameLabel.preferredMaxLayoutWidth=userNameLabel.frame.size.width
    }

    @IBAction func onRetweet(sender: AnyObject) {
        var retweets = Int(retweetCount.text!)
        retweetCount.text=String(retweets! + 1)
        
        if(retweeted){
            retweetCount.text=String(retweets! - 1)
            retweeted=false
        }else{
            retweetCount.text=String(retweets! + 1)
            retweeted=true
        }
        
    }
    
    
    @IBAction func onFavorite(sender: AnyObject) {
        var favs = Int(favoritesCount.text!)
        favoritesCount.text=String(favs! + 1)
        
        if(favorited){
            favoritesCount.text=String(favs! - 1)
            favorited=false
        }else{
            favoritesCount.text=String(favs! + 1)
            favorited=true
        }
    }
    
    func updateCounts() {
        favoritesCount.text = String(tweet?.favorites_count)
        retweetCount.text = String(tweet?.retweetCount)
    }
}
