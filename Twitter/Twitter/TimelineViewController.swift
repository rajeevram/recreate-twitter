//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource, ComposeViewControllerDelegate {
    
    // Graphics
    @IBOutlet weak var tweetTableView: UITableView!
    
    // Backend
    var tweets : [Tweet] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Table View Data Source
        tweetTableView.dataSource = self
        tweetTableView.rowHeight = UITableViewAutomaticDimension
        tweetTableView.estimatedRowHeight = 100
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
    
    // Network Request
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
    
    @IBAction func didTapCompose(_ sender: Any) {
        self.performSegue(withIdentifier: "ComposeSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ComposeSegue") {
            if let composeView = segue.destination as? ComposeViewController {
                composeView.delegate = self
                composeView.user = User.current
            }
        }
        if (segue.identifier == "DetailSegue") {
            if let detailView = segue.destination as? DetailViewController {
                if let cell = sender as! TweetCell? {
                    detailView.tweet = tweets[(cell.indexPath?.row)!]
                }
                detailView.user = User.current
            }
        }
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetTableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        cell.user = User.current
        cell.indexPath = indexPath
        cell.updateAllContent()
        cell.parentView = self as TimelineViewController
        return cell
    }
    
    // Protocol
    func did(post : Tweet) {
        completeNetworkRequest()
        //print("The delegation worked!")
    }
    
}
