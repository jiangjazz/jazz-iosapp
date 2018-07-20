//
//  Networking.swift
//  xclub
//
//  Created by 姜锺超 on 2018/7/18.
//  Copyright © 2018年 姜锺超. All rights reserved.
//

import UIKit
/// 引用Alamofire
import Alamofire

/// 单例设计模式的请求class
@objcMembers
class Networking: NSObject {
    /// 请求头 读取全局数据
    var HTTPHeaderDics: Dictionary<String, String> = Net.head
    /// 请求参数
    var parameters: Parameters = [:]
    /// 使用单例对象形式做请求
    static let sharedNetWorking = Networking()
    
    /// get方法
    ///
    /// - Parameters:
    ///   - url: 请求路径
    ///   - finish: 请求成功执行
    class func requestGet(url: String, finish: @escaping (Bool, Data) -> Void) {
        
        Alamofire.request("\(Config.baseurl)\(url)", method: .get, parameters: sharedNetWorking.parameters).responseJSON { response in
            print("GET Request: \(String(describing: response.request))")   // original url request
            //            print("Response: \(String(describing: response.response))") // http url response
            //            print("Result: \(response.result)")                         // response serialization result
            //            print(response.error ?? "")
            //            if let json = response.result.value {
            //                print("JSON: \(json)") // serialized json response
            //            }
            
            //            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            //                print("Data: \(utf8Text)") // original server data as UTF8 string
            //            }
            guard response.error != nil || response.result.value == nil else {
//                finish(true, response.data!)
                finish(true, response.data!)
                return
            }
        }
    }
    
    /// post方法
    ///
    /// - Parameters:
    ///   - url: 请求路径
    ///   - finish: 请求成功执行
    class func requestPost(url: String, finish: @escaping (Bool, Data) -> Void) {
        Alamofire.request("\(Config.baseurl)\(url)", method: .post, parameters: sharedNetWorking.parameters, encoding: URLEncoding.httpBody).responseJSON { response in
            print("POST Request: \(String(describing: response.request))")   // original url request
            //            print("Response: \(String(describing: response.response))") // http url response
            //            print("Result: \(response.result)")                         // response serialization result
            //            print("Error: \(response.error)")
            //            if let json = response.result.value {
            //                print("JSON: \(json)") // serialized json response
            //            }
            
            //            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            //                print("Data: \(utf8Text)") // original server data as UTF8 string
            //            }
            guard response.error != nil else {
                finish(true, response.data!)
                return
            }
        }
    }
}
