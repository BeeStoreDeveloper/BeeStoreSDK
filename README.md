# 开发文档

## 关于BeeStoreSDK
##### 该SDK会收集用户应用及设备的部分信息
* 用于**监测**用户已安装应用是否**掉签**
* 配合BeeStore为用户提供最新的**最新签名安装包**。

## 未来
* 在未来将逐步开发**数据统计**、**授权登录**、**第三方钱包支付**等相关功能，通过多项数据，为项目方和用户提供更多服务，扶植更多优质项目方落地与宣发，***BeeStore立志成为区块链行业的App Store***。

## 运行环境
* 本SDK使用swift4.2开发、最低支持到iOS9.0

## 如何使用
1. 允许项目使用http请求（添加到info.plist）
2. 添加白名单（添加到info.plist）

    ```
    <key>NSAppTransportSecurity</key>
    <dict>
    	<key>NSAllowsArbitraryLoads</key>
    	<true/>
    </dict>
    ```
    ```
    <key>LSApplicationQueriesSchemes</key>
    <array>
        <!-- BeeStore URL Scheme 白名单-->
        <string>BeeStore</string>
    </array>
    ```
3. 在应用启动声明周期方法中添加一下代码:
    ```objc
    let configure = BS_Configure(appKey: "BeeStoreSDKTest", appSecret: "FthGjkLhgTtghJyft")
            
    // 开发调试模式（上线时要修改成 false）
    configure.debugMode = true
    
    BS_Manager.start(configure: configure) { (result) in
        if result {
            // 启动成功
        } else {
            // 启动失败
        }
    }
    ```

## API说明
#### 配置
```objc
open class BS_Configure: NSObject {
    
    @objc convenience public init(appKey: String, appSecret: String) {}
    
    /// 是否开发调试模式
    @objc open var debugMode = true
}
```

#### 功能管理
```objc
open class BS_Manager: NSObject {
    
    /// 启动 SDK 功能
    @objc open class func start(configure: BS_Configure, result: @escaping (Bool) -> ()) {}
    
    /// 获取bsuuid（BeeStore定义的设备唯一标示）
    @objc open class var bsuuid: String {}
    
    /// 是否安装BeeStore
    @objc open class var isInstallBeeStore: Bool {}
    
    /// 打开BeeStore
    @objc open class func openBeeStore() -> Bool {}
    
    /// SDK 版本
    open class var sdkVersion: String { get }
```

## 联系我
如果发现bug请issue。有疑问或者获取appKey、appSecret，可以发邮件到developer@beestore.io答疑、申请。