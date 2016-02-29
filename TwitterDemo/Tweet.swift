//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Parth Bhardwaj on 2/26/16.
//  Copyright © 2016 Parth Bhardwaj. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favorites_count: Int=0
    var tweetId: String?
    var favorited: Bool?
    var retweeted: Bool?
    
    init(dictionary: NSDictionary){
        
        user=User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favorites_count=(dictionary["favourites_count"] as? Int) ?? 0
        let timeStampString=dictionary["created_at"] as? String
        tweetId = dictionary["id_str"] as? String
        favorited = dictionary["favorited"] as? Bool
        retweeted = dictionary["retweeted"] as? Bool
        
        if let timeStampString=timeStampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat="EEE MMM d HH:mm:ss Z y"
            timestamp=formatter.dateFromString(timeStampString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets=[Tweet]()
        
        for dictionary in dictionaries{
            let tweet=Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        
        return tweets
    }
}
