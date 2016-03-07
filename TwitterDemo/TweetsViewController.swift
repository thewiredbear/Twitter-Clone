//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Parth Bhardwaj on 2/26/16.
//  Copyright © 2016 Parth Bhardwaj. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]?
    var tweet: Tweet?
    var user: User?
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets=tweets
            self.tableView.reloadData()
            }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }
        
//        TwitterClient.sharedInstance.currentAccount({ (users: User) -> () in
//            self.users=users
//            self.tableView.reloadData()
//            }) { (error: NSError) -> () in
//                print(error.localizedDescription)
//        }
        
        tableView.dataSource=self
        tableView.delegate=self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight=120
        
        // Initialize a UIRefreshControl
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil{
            return (tweets?.count)!
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        let tweet=self.tweets![indexPath.row]
        
        cell.userNameLabel.text=tweet.user!.name as? String
        cell.tweetLabel.text=tweet.text as? String
        if let profileURL = tweet.user?.profileURL{
            cell.profileImageView.setImageWithURL(profileURL)
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d"
        cell.timeStampLabel.text = formatter.stringFromDate(tweet.timestamp!)
        
        cell.retweetCount.text = String(tweet.retweetCount)
        cell.favoritesCount.text = String(tweet.favorites_count)
        
        return cell
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        
        // Make network request to fetch latest data
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
        }

        // Do the following when the network request comes back successfully:
        // Update tableView data source
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }


    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "detailSegue"){
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            
            let tweetDetailVC = segue.destinationViewController as! DetailViewController
            tweetDetailVC.tweet = tweet
        }
        else if (segue.identifier) == "profileSegue" {
            
            
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! TweetCell
            
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let user = tweet.user
            
            let profileViewController = segue.destinationViewController as! ProfileViewController
            profileViewController.user = user
            
        }
        else if (segue.identifier) == "composeSegue" {
            
            let user = User.currentUser
            
            let composeTweetViewController = segue.destinationViewController as! ComposeController
            composeTweetViewController.user = user
        }
    }
    

}
