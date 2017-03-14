//
//  BookExtension.swift
//  toBook
//
//  Created by Mac on 16/12/18.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImage {
    
    //将image转换为size大小
    func resizeToSize(size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0) //联系上下文
        drawInRect(CGRectMake(0, 0, size.width, size.height))   //重新图片调整大小
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()  //从上下文获取得到的图片
        UIGraphicsEndImageContext() //关闭上下文
        return newImage
        
    }
}

extension UIImageView {
    
    func setResizeImageWith(URLString: String , width:CGFloat) {
        let URL = NSURL(string: URLString)  //获取url地址
        let key = SDWebImageManager.sharedManager().cacheKeyForURL(URL) ?? "" //从缓存中获取图片
        //判断缓存中是否有照片
        if var cacheImage = SDImageCache.sharedImageCache().imageFromCacheForKey(key) {
            if cacheImage.size.width > width {
                let size = CGSizeMake(width, cacheImage.size.height * (width/cacheImage.size.width))
                cacheImage = cacheImage.resizeToSize(size)
            }
            self.image = cacheImage
        }else{
            SDWebImageDownloader.sharedDownloader().downloadImageWithURL(URL, options: SDWebImageDownloaderOptions.AllowInvalidSSLCertificates, progress: nil, completed: { ( var forimage, data, error, result) in
                if forimage != nil && forimage!.size.width > width {
                    let size = CGSizeMake(width, forimage!.size.height * (width/forimage!.size.width))
                    forimage = forimage!.resizeToSize(size)
                }
                self.image = forimage
            })
        }
    }
}

//            SDWebImageDownloader.sharedDownloader().downloadImageWithURL(URL, options: .AllowInvalidSSLCertificates, progress: nil, completed: { (var image, data, error, result) -> Void in
//                if image != nil && image.size.width > width {
//                    let size = CGSizeMake(width, image.size.height * (width / image.size.width))
//                    
//                    image = image.resizeToSize(size)
//                }
//                self.image = image
//            })
//        }
//    }
//}
