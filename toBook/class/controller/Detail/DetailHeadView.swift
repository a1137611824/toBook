//
//  DetailHeadView.swift
//  toBook
//
//  Created by Mac on 16/12/20.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class DetailHeadView: UIView {
    //MARK: --Property
    var tableView: UITableView!
    var book: Books!
    
    //MARK: --IBOutlet
    @IBOutlet var imageViewIcon: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var viewRating: UIView!
    @IBOutlet var viewRatingNum: UILabel!
    @IBOutlet var labelPublish: UILabel!
    @IBOutlet var labelSummary: UILabel!
    
    @IBOutlet weak var viewContainer: UIView!
    
    
    
    static func showInTableView(tableView: UITableView , book: Books) -> DetailHeadView {
        let headView = NSBundle.mainBundle().loadNibNamed("DetailHeadView", owner: nil, options: nil)[0] as! DetailHeadView
        headView.configureWith(tableView, book: book)
        return headView
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame.size.height = viewContainer.frame.size.height
        tableView.tableHeaderView = self
    }
    
    func configureWith(tableView: UITableView , book:Books) {
        self.tableView = tableView
        self.book = book
        
        imageViewIcon.sd_setImageWithURL(NSURL(string: book.images["large"] ?? ""))
        
        labelTitle.text = book.title
        
        if let forRate = book.rating {
            RatingView.showInView(viewRating, value: forRate.average)
            viewRatingNum.text = "\(forRate.numRaters)人评分"
        }else{
            RatingView.showNoRating(viewRating)
        }
        
        var desc = ""
        for str in book.author {
            desc += (str + "/")
        }
        labelPublish.text = desc + book.publisher + "/" + book.pubdate
        labelSummary.text = book.summary
        self.tableView.tableHeaderView = self
        
       
    }
    

    
}
