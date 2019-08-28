//
//  BS_Manager.swift
//  BeeStoreTempleDemo
//
//  Created by jianyue on 2019/7/22.
//  Copyright © 2019 LYCoder. All rights reserved.
//

import UIKit
import Foundation
//import b

open class BS_Manager: NSObject {
    
    /// 启动 SDK 功能
    @objc open class func start(configure: BS_Configure, result: @escaping (Bool) -> ()) {
        
        self.configure = configure
        
        requestNetwork { (networkResult) in
            result(networkResult)
        }
    }
    
    /// 获取bsuuid（BeeStore定义的设备唯一标示）
    @objc open class var bsuuid: String {
        let pasteboard = UIPasteboard(name: UIPasteboard.Name("BSUUID"), create: true)
        if let pasteboardData = pasteboard?.data(forPasteboardType: "BSUUIDPasteboardType") {
            return String(data: pasteboardData, encoding: .utf8) ?? ""
        }
        let token = String(UInt(Date().timeIntervalSince1970)) + String.random(10)
        pasteboard?.setData(token.data(using: .utf8)!, forPasteboardType: "BSUUIDPasteboardType")
        return token
    }
    
    /// 是否安装BeeStore
    @objc open class var isInstallBeeStore: Bool {
        return UIApplication.shared.canOpenURL(URL(string: "BeeStore://")!)
    }
    
    /// 打开BeeStore
    @objc open class func openBeeStore() -> Bool {
        if isInstallBeeStore {
            UIApplication.shared.openURL(URL(string: "BeeStore://")!)
        }
        return isInstallBeeStore
    }
    
    /// SDK 版本
    open class var sdkVersion: String { get { return "0.1" } }
    
    
    fileprivate class func requestNetwork(result: @escaping (Bool) -> ()) {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        let session = URLSession.shared
        
        let url = URL(string: "http://47.92.31.230:8088/beestore/iosSdk/saveInfo")
        var request = URLRequest(url: url!)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(configure.appKey, forHTTPHeaderField: "appKey")
        request.addValue(configure.appSecret, forHTTPHeaderField: "appSecret")
        
        let params = ["bundleId": bs_bundleIdentifier,
                      "appName": bs_displayName,
                      "version": bs_shortVersionString,
                      "bundleVersion": bs_versionString,
                      "deviceId": bsuuid,
                      "deviceType": identifier,
                      "systemVersion": UIDevice.current.systemVersion,
                      "sdkVersion": sdkVersion]
        
        
        request.httpMethod = "POST"
        var jsonData: Data? = nil
        do {
            jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch {
            
        }
        
        
        
        // 将字符串转换成数据
        request.httpBody = jsonData
        
        request.timeoutInterval = 20
        
        let task = session.dataTask(with: request) { (data, resp, err) in
            if let resp = resp as? HTTPURLResponse, resp.statusCode == 200 {
                // 网络请求成功
                result(true)
            } else {
                // 网络请求失败
                result(false)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10, execute: {
                    requestNetwork(result: { (result) in
                    })
                })
            }
        }
        // 恢复任务
        task.resume()
    }
}

extension BS_Manager {
    
    static var configure: BS_Configure!
    
    
}

extension String {
    /// 生成随机字符串
    ///
    /// - Parameters:
    ///   - count: 生成字符串长度
    ///   - isLetter: false=大小写字母和数字组成，true=大小写字母组成，默认为false
    /// - Returns: String
    static func random(_ count: Int, _ isLetter: Bool = false) -> String {
        
        var ch: [CChar] = Array(repeating: 0, count: count)
        for index in 0..<count {
            
            var num = isLetter ? arc4random_uniform(58)+65:arc4random_uniform(75)+48
            if num>57 && num<65 && isLetter==false { num = num%57+48 }
            else if num>90 && num<97 { num = num%90+65 }
            
            ch[index] = CChar(num)
        }
        
        return String(cString: ch)
    }
}
