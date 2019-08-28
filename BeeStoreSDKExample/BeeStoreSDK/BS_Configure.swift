//
//  BS_Configure.swift
//  BeeStoreTempleDemo
//
//  Created by jianyue on 2019/7/22.
//  Copyright © 2019 LYCoder. All rights reserved.
//

import UIKit

open class BS_Configure: NSObject {
    
    @objc convenience public init(appKey: String, appSecret: String) {
        self.init()
        
        self.appKey = appKey
        self.appSecret = appSecret
    }
    
    // MARK: - 公有属性
    
    /// 是否开发调试模式
    @objc open var debugMode = true
    
    // MARK: - 私有属性
    
    public var appKey: String = ""
    
    public var appSecret: String = ""
    
    public override init() { super.init() }
}
