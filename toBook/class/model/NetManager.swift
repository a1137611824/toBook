//
//  NetManager.swift
//  readBook
//
//  Created by Mac on 16/12/14.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
import Toast

struct NetManager{
    static let netError = "网络错误，请检查网络"
    static let URLStringBooks = "https://api.douban.com/v2/book/search"
    static let pageSize = 10
    static let KeyBooks = "books"
    
    
    static func getReviewsWithBookId(bookId: String,page:Int,resultClosure:(Bool,[Review]!)->Void) {
        GET("https://api.douban.com/v2/book/\(bookId)/reviews", parameters: ["start":page * pageSize,"count":pageSize], showHUD:false, success: { (responseObject) -> Void in
            var reviews = [Review]()
            if let reviewsArray = (responseObject as? [String:NSObject])?["reviews"] as? [[String:NSObject]] {
                for dict in reviewsArray {
                    reviews.append(Review(dict:dict))
                }
            }
            resultClosure(true,reviews)
            },failure: { (error) -> Void in
                resultClosure(false,nil)
        })
    }
    
    
    static func getBooks(tag: String, page: Int,resultClosure:(Bool,[Books]!) -> Void) {
        NetManager.GET(URLStringBooks, parameters: ["tag":tag, "start": page * pageSize], showHUD: false, success: { (responseObject) in
            var books = [Books]()
            if let dict = responseObject as? [String:NSObject], array = dict[self.KeyBooks] as? [[String:NSObject]] {
                for dict in array {
                    books.append(Books(dict: dict))
                }
            }
            resultClosure(true,books)
            }) { (error) in
                resultClosure(false,nil)
        }
    }
    
    
    static func getBookTitles(tag: String, page: Int ,resultClosure: ([String]) -> Void) {
        NetManager.GET(URLStringBooks, parameters: ["tag":tag, "start":0, "count": 10, "fields": "title"], showHUD: false, success: { (responseObject) in
                var searchTitles = [String]()
                if let dict = responseObject as? [String:NSObject], array = dict[self.KeyBooks] as? [[String:NSObject]] {
                    for dict in array {
                        if let title = dict["title"] as? String {
                            searchTitles.append(title)
                        }
                    }
                }
            resultClosure(searchTitles)
            }) { (error) in
                
        }
    }
    
    
    static func GET(URLString:String, parameters:[String:NSObject]?, showHUD:Bool = true, success:((NSObject?) -> Void)?, failure:((NSError) -> Void)?) {
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10
        
        let mainWindow = UIApplication.sharedApplication().delegate!.window!
        
        if showHUD {
            MBProgressHUD.showHUDAddedTo(mainWindow!, animated: true)
        }
        
        manager.GET(URLString, parameters: parameters, success: { (task, responseObject) -> Void in
            if showHUD {
                MBProgressHUD.hideHUDForView(mainWindow!, animated: true)
            }
            success?(responseObject as? NSObject)
        }) { (task, error) -> Void in
            if showHUD {
                MBProgressHUD.hideHUDForView(mainWindow!, animated: true)
                mainWindow?.makeToast(netError)
            }
            failure?(error)
        }
    }

    
}


