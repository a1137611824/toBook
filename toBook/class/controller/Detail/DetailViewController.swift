//
//  DetailViewController.swift
//  toBook
//
//  Created by Mac on 16/12/20.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{

    var book: Books!
    var page = 0
    var reviews = [Review]()
    
    @IBOutlet var fortitle: UILabel!
    
    @IBOutlet var forTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if book != nil {
            DetailHeadView.showInTableView(forTableView, book: book)
            fortitle.text = book.title
        } else {
            forTableView.footerEndRefreshNoMoreData()
        }
        
        forTableView.estimatedRowHeight = 50
        forTableView.rowHeight = UITableViewAutomaticDimension
        forTableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(animated: Bool) {
        forTableView.footerAddMJRefresh { () -> Void in
            NetManager.getReviewsWithBookId(self.book.id, page: self.page, resultClosure: { (result, reviews) -> Void in
                if result {
                    let count = self.reviews.count
                    var indexPaths = [NSIndexPath]()
                    for (i,review) in reviews.enumerate() {
                        self.reviews.append(review)
                        indexPaths.append(NSIndexPath(forRow: count+i, inSection: 0))
                    }
                    if indexPaths.isEmpty {
                        self.forTableView.footerEndRefreshNoMoreData()
                    } else {
                        self.page += 1
                        self.forTableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
                        self.forTableView.footerEndRefresh()
                    }
                } else {
                    self.view.makeToast("网络异常，请上拉重试")
                    self.forTableView.footerEndRefresh()
                }
            })
        }
        
        forTableView.footerBeginRefresh()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReViewCell") as! ReViewCell
        cell.configureWithReview(reviews[indexPath.row])
        return cell
    }
    
    
    @IBAction func doBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }



}
