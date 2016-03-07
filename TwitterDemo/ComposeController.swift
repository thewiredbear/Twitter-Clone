//
//  ComposeController.swift
//  TwitterDemo
//
//  Created by Parth Bhardwaj on 3/6/16.
//  Copyright © 2016 Parth Bhardwaj. All rights reserved.
//

import UIKit

class ComposeController: UIViewController, UITextViewDelegate {
    
    var user: User?
    var tweet: Tweet?
    var userNameHandleText: String?
    var tweetContent: String = ""
    var isReply: Bool?
    
    
//    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
//    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userName: UILabel!
//    @IBOutlet weak var userNameHandle: UILabel!
    @IBOutlet weak var userNameHandle: UILabel!
//    @IBOutlet weak var characterLimit: UILabel!
    @IBOutlet weak var characterLimit: UILabel!
//    @IBOutlet weak var composeNewTweetView: UITextView!
    @IBOutlet weak var composeNewTweetView: UITextView!
//    @IBOutlet weak var sendTweetButton: UIBarButtonItem!
    @IBOutlet weak var sendTweetButton: UIButton!
//    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var placeHolderLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        composeNewTweetView.delegate = self
        userNameHandle.text = "@\(User.currentUser!.screenname!)"
        userName.text = User.currentUser!.name as? String
        profilePictureImageView.setImageWithURL((User.currentUser?.profileURL!)!)
        
        
        placeHolderLabel.text = ""
        composeNewTweetView.addSubview(placeHolderLabel)
        placeHolderLabel.hidden = !composeNewTweetView.text.isEmpty
        
        composeNewTweetView.becomeFirstResponder()
        
        //***************************************
        if (isReply) == true {
            composeNewTweetView.text = "@\((tweet?.user?.screenname)!)"
            if  0 < (141 - composeNewTweetView.text!.characters.count) {
                sendTweetButton.enabled = true
                characterLimit.text = "\(140 - composeNewTweetView.text!.characters.count)"
            }
            else{
                sendTweetButton.enabled = false
            }
            isReply = false
        }


        // Do any additional setup after loading the view.
    }

    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});//This is intended to dismiss the Info sceen.
        print("pressed")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func sendTweet(sender: AnyObject) {
        
        tweetContent = composeNewTweetView.text
        
        let escapedTweetMessage = tweetContent.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        
        if isReply == true {
            TwitterClient.sharedInstance.reply(escapedTweetMessage!, statusID: Int(tweet!.id)!, params: nil, completion: { (error) -> () in
                print("replying")
                
            })
            
            isReply = false
            navigationController?.popViewControllerAnimated(true)
        } else {
            TwitterClient.sharedInstance.compose(escapedTweetMessage!, params: nil, completion: { (error) -> () in
                print("composing")
            })
            navigationController?.popViewControllerAnimated(true)
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
