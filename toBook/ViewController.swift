//
//  ViewController.swift
//  toBook
//
//  Created by Mac on 16/12/16.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{

    //MARK: --Property--
    let IDBookCell = "BookCell"
    var tag = "Swift"
    var books = [Books]()
    var page = 0
    let pageSize = 10
    
    //MARK: --IBOutlet--
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMJHeaderAndFooter()
        tableView.headerBeginRefresh()
        
        // 自动计算行高
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //设置searchBar
        let searchController = storyboard?.instantiateViewControllerWithIdentifier("BookSearchView") as! BookSearchView
        searchController.bookController = self
        searchView.addSubview(searchController.searchController.searchBar)
        
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let forDatailView = storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        forDatailView.book = books[indexPath.row]
        navigationController?.pushViewController(forDatailView, animated: false)
    }
    
    //MARK: --UITableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCellWithIdentifier(IDBookCell, forIndexPath: indexPath) as! BookCell
        bookCell.configureWithBook(books[indexPath.row])
        return bookCell
    }
    
    
    //MARK: -- MJRefresh
    private func addMJHeaderAndFooter() {
        //顶部刷新
        tableView.headerAddMJRefresh { 
            self.tableView.footerResetNoMoreData()
            //进行网络请求
            NetManager.getBooks(self.tag, page: 0, resultClosure: { (result, books) in
                self.tableView.headerEndRefresh()
                if result {
                    self.page = 1
                    self.books = books
                    self.tableView.reloadData()
                }else{
                    self.view.makeToast("请求数据失败")
                }
            })
        }
        
        //底部刷新
        tableView.footerAddMJRefresh {
            NetManager.getBooks(self.tag, page: self.page, resultClosure: { (result, books) in
                if result {
                    //新建书的数组
                    var indexPaths = [NSIndexPath]()
                    let count = self.books.count
                    //带索引的数组遍历
                    for (i,book) in books.enumerate() {
                        self.books.append(book)
                        indexPaths.append(NSIndexPath(forRow: count + i ,inSection: 0))
                    }
                    if indexPaths.isEmpty {
                        self.tableView.footerEndRefreshNoMoreData()
                    }else{
                        self.page += 1
                        self.tableView.footerEndRefresh()
                        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
                    }
                }else{
                    self.tableView.headerEndRefresh()
                    self.view.makeToast("请求数据失败")
                }
            })
            
        }
    }


    

}

