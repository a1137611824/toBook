//
//  ReViewCell.swift
//  toBook
//
//  Created by Mac on 16/12/20.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class ReViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewHead: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var viewRatingContent: UIView!
    
    @IBOutlet weak var labelSummary: UILabel!
    @IBOutlet weak var labelRatingNum: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    func configureWithReview(review:Review) {
        imageViewHead.sd_setImageWithURL(NSURL(string: review.author.avatar))
        labelTitle.text = review.title
        labelName.text = review.author.name
        if let rating = review.rating {
            RatingView.showInView(viewRatingContent, value: rating.average)
            labelRatingNum.text = Int(rating.numRaters).description
        } else {
            RatingView.showNoRating(viewRatingContent)
        }
        labelSummary.text = review.summary
        labelDate.text = review.updated
    }
}
