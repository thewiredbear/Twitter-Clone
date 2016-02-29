//
//  User.swift
//  TwitterDemo
//
//  Created by Parth Bhardwaj on 2/26/16.
//  Copyright © 2016 Parth Bhardwaj. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: NSString?
    var screenname: NSString?
    var profileURL: NSURL?
    var tagline: NSString?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary=dictionary
        name=dictionary["name"] as? String
        screenname=dictionary["screen_name"] as? String
        
        
        let profileURLString=dictionary["profile_image_url_https"] as? String
        if let profileURLString=profileURLString{
            profileURL = NSURL(string: profileURLString)
        }
        
        
        tagline=dictionary["description"] as? String
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    static var _currentUser:User?
    
    class var currentUser: User? {
        get {
        if _currentUser == nil {
        let defaults = NSUserDefaults.standardUserDefaults()
        let userData = defaults.objectForKey("currentUserData") as? NSData
        
        if let userData = userData {
        let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
        _currentUser = User(dictionary: dictionary)
        }
        }
        return _currentUser
        }
        set(user) {
            _currentUser = user
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
    
}
