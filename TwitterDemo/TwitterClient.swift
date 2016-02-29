//
//  TwittterClient.swift
//  TwitterDemo
//
//  Created by Parth Bhardwaj on 2/26/16.
//  Copyright © 2016 Parth Bhardwaj. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
        
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "5zxMhD3m2VHgZWKuP6vvwGk3B", consumerSecret: "1p56Qy1IFdtJeBUOJ5VThPdK9o9cXxxgoYKx937B9dUSjBhA6z")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func currentAccount(success: (User) -> (),failure: (NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil,progress: nil, success: { (task:NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("account \(response)")
            let userDictionary=response as! NSDictionary
            
            
            //print("user: \(user)")
            
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            print("name: \(user.name)")
            print("screenname: \(user.screenname)")
            print("profile url: \(user.profileURL)")
            //print("name: \(user.name)")
            print("description: \(user.tagline)")
        }, failure: { (task:NSURLSessionDataTask?, error: NSError) -> Void in
            failure(error)
        })

    }
    
    func homeTimeline(success: ([Tweet]) -> (),failure: (NSError) -> ()){
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries=response as! [NSDictionary]
            
            let tweets=Tweet.tweetsWithArray(dictionaries)
            
            print("hell")
            
            success(tweets)
            
            }, failure: { (task:NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })

    }
    
    func login(success: () -> (), failure: (NSError) -> ()){
        loginSuccess=success
        loginFailure=failure
        
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken:BDBOAuth1Credential!) -> Void in
            print("I got a token")
            
            let url=NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func handleOpenURL(url: NSURL){
        let requestToken=BDBOAuth1Credential(queryString: url.query)
        
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken:BDBOAuth1Credential!) -> Void in
            print("I got the access token")
            
            self.currentAccount({ (user:User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
            
            
            }) { (error:NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func logout(){
        User.currentUser=nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    
    func retweet(id: String) {
        POST("1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Retweet")
            },
            failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Error retweeting")
            }
        )
    }
    
    func createFav(id: String) {
        POST("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Create a favorite")
            },
            failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Error creating a favorite")
            }
        )
    }
    //func retweetContent(
}
