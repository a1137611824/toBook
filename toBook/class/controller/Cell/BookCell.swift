//
//  BookCell.swift
//  toBook
//
//  Created by Mac on 16/12/16.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
import SDWebImage

class BookCell: UITableViewCell {
    
    @IBOutlet var imageViewIcon: UIImageView!
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var detailLable: UILabel!
    @IBOutlet var rating: UIView!
    
    func configureWithBook(book: Books) {
        
//        imageViewIcon.sd_setImageWithURL(NSURL(string: book.image))
        imageViewIcon.setResizeImageWith(book.image, width: imageViewIcon.frame.size.width)
        titleLable.text = book.title
        
        if let forRate = book.rating {
            RatingView.showInView(rating, value: forRate.average)
        }else{
            RatingView.showNoRating(rating)
        }
        
        var detail = ""
        for str in book.author {
            detail += (str + "/")
        }
        detailLable.text = detail + book.publisher + "/" + book.pubdate
    }
    

    
}
