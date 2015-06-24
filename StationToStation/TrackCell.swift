//
//  TrackCell.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/9/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

enum VoteState {
    case Bump, Drop, Neutral
}

protocol TrackCellDelegate {
    func trackCell(sender: TrackCell, didChangeVote: VoteState)
}

class TrackCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var bumpCountLabel: UILabel!
    @IBOutlet weak var dropCountLabel: UILabel!
    @IBOutlet weak var bumpButton: UIButton!
    @IBOutlet weak var dropButton: UIButton!
    
    var delegate: TrackCellDelegate?
    
    var track: Track! {
        didSet {
            iconImageView.setImageWithURL(NSURL(string: track.albumImageUrl))
            titleLabel.text = track.trackTitle
            artistLabel.text = track.artistName
            bumpCountLabel.text = "\(track.bumps ?? 0) Bumps"
            dropCountLabel.text = "\(track.drops ?? 0) Drops"
            
            if let voteState = track.voteState {
                switch voteState {
                case .Bump:
                    bumpButton.setImage(UIImage(named: "up_arrow_active"), forState: .Normal)
                    dropButton.setImage(UIImage(named: "down_arrow"), forState: .Normal)
                case .Drop:
                    bumpButton.setImage(UIImage(named: "up_arrow"), forState: .Normal)
                    dropButton.setImage(UIImage(named: "down_arrow_active"), forState: .Normal)
                case .Neutral:
                    bumpButton.setImage(UIImage(named: "up_arrow"), forState: .Normal)
                    dropButton.setImage(UIImage(named: "down_arrow"), forState: .Normal)
                }
            } else {
                bumpButton.setImage(UIImage(named: "up_arrow"), forState: .Normal)
                dropButton.setImage(UIImage(named: "down_arrow"), forState: .Normal)
            } 
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //titleLabel.preferredMaxLayoutWidth = titleLabel.frame.size.width
        //artistLabel.preferredMaxLayoutWidth = artistLabel.frame.size.width
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onBump(sender: AnyObject) {
        if track.voteState == .Bump {
            delegate?.trackCell(self, didChangeVote: .Neutral)
        } else {
            delegate?.trackCell(self, didChangeVote: .Bump)
        }
    }
    
    @IBAction func onDrop(sender: AnyObject) {
        if track.voteState == .Drop {
            delegate?.trackCell(self, didChangeVote: .Neutral)
        } else {
            delegate?.trackCell(self, didChangeVote: .Drop)
        }
    }
}
