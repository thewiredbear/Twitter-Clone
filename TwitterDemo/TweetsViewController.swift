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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
