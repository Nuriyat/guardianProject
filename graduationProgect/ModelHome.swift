//
//  ModelHome.swift
//  graduationProgect
//
//  Created by admin on 20/06/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import Alamofire

struct Home {
    var imageHome: String
    var labelHome: String
    var url: String
}

struct News {
    var imageNew: String
    var titleNew: String
    var description: String
    var url: String
}

class ModelHome {
    func getImageHome(url: URL, success: @escaping ([[String: Any]]) -> Void, failure: @escaping (String) -> Void) {
        request(url).responseJSON { (response) in
            if response.result.isSuccess {
                    if let result = response.result.value as? [[String: Any]]{
                        success(result)
                    }else{
                        failure("noResult")
                    }
                }else {
                failure("noResponse")
            }
        }
    }
    
    func getNews(url: URL, success: @escaping ([[String: Any]]) -> Void, failure: @escaping (String) -> Void) {
        request(url).responseJSON { (response) in
            if response.result.isSuccess {
                if let result = response.result.value as? [[String: Any]]{
                    success(result)
                }else{
                    failure("noResult")
                }
            }else {
                failure("noResponse")
            }
        }
    }
    
    func getNewsDetails(url: URL, success: @escaping ([String: Any]) -> Void, failure: @escaping (String) -> Void) {
        request(url).responseJSON { (response) in
            if response.result.isSuccess {
                if let result = response.result.value as? [String: Any]{
                    success(result)
                }else{
                    failure("noResult")
                }
            }else {
                failure("noResponse")
            }
        }
    }
    
    
    func getImageHomeDetails(url: URL, success: @escaping ([String: Any]) -> Void, failure: @escaping (String) -> Void) {
        request(url).responseJSON { (response) in
            if response.result.isSuccess {
                if let result = response.result.value as? [String: Any]{
                    success(result)
                }else{
                    failure("noResult")
                }
            }else {
                failure("noResponse")
            }
        }
    }
}
