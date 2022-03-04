//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Makayla Rodriguez on 3/1/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    
    @IBOutlet weak var rtBtn: UIButton!
    @IBOutlet weak var favBtn: UIButton!
    
    var favorited:Bool = false
    
    var tweetId:Int = -1
    
    @IBAction func rtTweet(_ sender: Any) {
        
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweet(isRetweeted: true)
        }, failure: { (Error) in
            print("Error: setRetweet did not succeed")
        })
    }
    
    @IBAction func favTweet(_ sender: Any) {
        
        let toBfavorited = !favorited
        
        if toBfavorited {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: true)
            }, failure: { (Error) in
                print("Error: setFavorite did not succeed.")
            })
        }
        else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId) {
                self.setFavorite(isFavorited: false)
            } failure: { (Error) in
                print("Error: setFavorite did not succeed")
            }

        }
        
    }
    
    func setFavorite( isFavorited:Bool) {
        
        favorited = isFavorited
        
        if favorited {
            favBtn.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favBtn.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
        
    }
    
    func setRetweet( isRetweeted:Bool) {
        
        if isRetweeted {
            rtBtn.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            rtBtn.isEnabled = false
        }
        else {
            rtBtn.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            rtBtn.isEnabled = true
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
