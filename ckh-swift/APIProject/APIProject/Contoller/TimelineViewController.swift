//
//  TimelineViewController.swift
//  APIProject
//
//  Created by NEXTAcademy on 11/10/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class TimelineViewController: UIViewController {

    
    @IBOutlet weak var timelineTableView: UITableView!{
        didSet{
            timelineTableView.delegate = self
            timelineTableView.dataSource = self
            
            timelineTableView.tableFooterView = UIView()
            timelineTableView.rowHeight = UITableViewAutomaticDimension
            timelineTableView.estimatedRowHeight = 99.0
        }
    }
    var frDBref : FIRDatabaseReference!
    var tweets : [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frDBref = FIRDatabase.database().reference()
        fetchTweets()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: Internal Function
    private func fetchTweets(){
        frDBref.child("tweets").observe(.childAdded, with: { (snapshot) in
            // snapshot == data that given
            
            //creat new instance of tweet
            let newTweet = Tweet()
            
            //get the data from snapshot
            guard let tweetDict = snapshot.value as? [String : AnyObject]
                else{
                    return
            }
            
            newTweet.username = tweetDict["username"] as? String
            newTweet.tweet = tweetDict["tweet"] as? String
            
            //
            self.tweets.append(newTweet)
            self.timelineTableView.reloadData()
            
        })
        
        
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TimelineViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : TweetCell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as? TweetCell else{
            return UITableViewCell()
        }
        
        let tweet = tweets[indexPath.row]
        
        cell.usernameLabel.text = tweet.username
        cell.tweetLabel.text = tweet.tweet
        
        return cell
    }
}

extension TimelineViewController :UITableViewDelegate {
    
}

