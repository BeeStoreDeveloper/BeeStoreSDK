//
//  BS_Macro.swift
//  BeeStoreTempleDemo
//
//  Created by jianyue on 2019/7/22.
//  Copyright © 2019 LYCoder. All rights reserved.
//

import Foundation

// 当前应用程序外部版本号
var bs_shortVersionString: String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
}

// 当前应用程序构建版本号
var bs_versionString: String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
}

// 当前应用程序名字
var bs_displayName: String {
    if let displayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
        return displayName
    }
    return ""
}

// 当前应用程序Bundle ID
var bs_bundleIdentifier: String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String
}

//// 当前应用UUID
//public var bs_bundleIdentifier: String {
//    return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String
//}

// 设备类型
