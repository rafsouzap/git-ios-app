//
//  ImageLoader.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 30/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import UIKit

final class ImageLoader {
    
    static let shared = ImageLoader()
    private let cache = NSCache<NSString, AnyObject>()
    
    func imageForUrl(urlString: String, completion: @escaping (_ image: UIImage?, _ url: String) -> ()) {
        
        DispatchQueue.global(qos: .background).async {
            let data: NSData? = self.cache.object(forKey: urlString as NSString) as? NSData
            
            if let dataFound = data {
                let image = UIImage(data: dataFound as Data)
                DispatchQueue.main.async {
                    completion(image, urlString)
                }
                return
            }
            
            RequestClient.shared.downloadImage(url: urlString, success: { data in
                let image = UIImage(data: data)
                self.cache.setObject(data as AnyObject, forKey: urlString as NSString)
                
                DispatchQueue.main.async {
                    completion(image, urlString)
                }
            }, failure: { fail in
                DispatchQueue.main.async {
                    completion(nil, urlString)
                }
            })
        }
    }
    
}
