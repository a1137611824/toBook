//
//  BookSearchView.swift
//  toBook
//
//  Created by Mac on 16/12/18.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class BookSearchView: UIViewController ,UISearchResultsUpdating , UITableViewDataSource , UITableViewDelegate{

    //MARK --proprety
    weak var bookController: ViewController!
    var searchController = UISearchController()
    var searchTitles = [String]()
    let searchPlaceholder = "搜索图书"
    
    //MARK --IBOutlet
    @IBOutlet var tableView: UITableView!
    
    
    override func awakeFromNib() {
        searchController = UISearchController(searchResultsController: self)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = searchPlaceholder
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.searchBar.subviews[0].subviews[0].removeFromSuperview()
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //字符串存在 不是空格也不是换行
        if let tag = searchController.searchBar.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) where !tag.isEmpty {
            
            NetManager.getBookTitles(tag, page: 0, resultClosure: { (titles) in
                self.searchTitles = titles
                self.tableView.reloadData()
            })
        }
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTitles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = searchTitles[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        searchController.active = false
        bookController.tag = searchTitles[indexPath.row]
        bookController.tableView.headerBeginRefresh()
    }

   
}
