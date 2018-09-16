//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource {
    
    // Graphics
    @IBOutlet weak var tweetTableView: UITableView!
    
    // Backend
    var tweets : [Tweet] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Table View Data Source
        tweetTableView.dataSource = self
        // Pull-To-Refresh
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TimelineViewController.completeNetworkRequest), for: .valueChanged)
        tweetTableView.insertSubview(refreshControl, at: 0)
        // Network Request
        self.completeNetworkRequest()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func completeNetworkRequest() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                self.tweets = tweets!
                self.tweetTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    // Event Handlers
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetTableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row]
        let user = User.current
        cell.updateAllContent(tweet: tweet, user: user!)
        return cell
    }
    
}
