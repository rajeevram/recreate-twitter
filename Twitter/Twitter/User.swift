//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var screenName: String?
    var profilepic: URL?
    var bannerpic: URL?
    var friendcount: Int?
    var followercount : Int?
    var userid: Int64?
    var favoritecount: Int?
    var statusCount : Int?

    // Dictionary
    var dictionary: [String: Any]?
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        name = dictionary["name"] as! String
        
        if let profile: String = dictionary["profile_image_url_https"] as? String {
            profilepic = URL(string: profile)!
        }
        
        if let banner : String = dictionary["profile_banner_url"] as? String {
            bannerpic = URL(string: banner)!
        }
        
        if let screen = dictionary["screen_name"] {
            self.screenName = screen as! String
        }
        
        friendcount = dictionary["friends_count"] as! Int
        followercount = dictionary["followers_count"] as! Int
        statusCount = dictionary["statuses_count"] as! Int
        
        //print(dictionary)
        
        guard let twitid: NSNumber = dictionary["id"] as? NSNumber else {
            print("Twitter ID Error")
            return
        }
        
        userid = twitid.int64Value
        favoritecount = dictionary["favourites_count"] as! Int
        //print("frineds \(friendcount)")
        
    }
    
    // User
    private static var _current: User?
    static var current: User?{
        get{
            let defaults = UserDefaults.standard
            if let userData = defaults.data(forKey: "currentUserData"){
                let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                return  User(dictionary: dictionary)
            }
            return nil
        }
        set(user){
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary, options: [])
                defaults.set(data, forKey: "currentUserData")
            }else{
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
}
