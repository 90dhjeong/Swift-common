//
//  DeviceInfo.swift
//
//  Created by 90dhjeong on 2019. 1. 21..
//  Copyright © 2019년 90dhjeong. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class DeviceInfo {
    /*******************
     기기 고유의 값인 uuid 를 얻어옴.
     만일, keyChain 에 존재한다면, 그 값을,
     아니라면, 새로운 uuid 를 생성한다.
     
     - Parameters
     X
     
     - Retruns
     @return uuid
     *******************/
    static func getUUID() -> String {
        //  keyChain 에서 긁어와서 없으면, 새로 발급 받은 후 keychain 에 저장
        let uuidString: String? = KeychainWrapper.standard.string(forKey: kSecAttrAccount as String)
        
        if var uuid = uuidString {
            // 값 존재
            print("uuid : " + uuid)
            
            let regx = "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-Z]{4}-[0-9A-F]{4}-[0-9A-F]{12}"
            let checkUuid = NSPredicate(format:"SELF MATCHES %@", regx)
            if  checkUuid.evaluate(with: uuid) {
                // 올바른 UUID
            } else {
                // 잘못된 UUID
                uuid = UUID.init().uuidString
                KeychainWrapper.standard.set(uuid, forKey: kSecAttrAccount as String)
            }
            return uuid
        } else {
            // 값 없음
            // 새로 생성해서 저장
            let uuid = UUID.init().uuidString
            KeychainWrapper.standard.set(uuid, forKey: kSecAttrAccount as String)
            return uuid
        }
    }
    
    /*******************
     현재 빌드 버전을 리턴
     
     - Parameters
     X
     
     - Retruns
     @return build version
     *******************/
    static func getBuildVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
            let build = dictionary["CFBundleVersion"] as? String else {return ""}
        
        return build
    }
    
    static func getPushToken() -> String {
        let pushToken = String(describing: UserDefaults.standard.object(forKey: Constants.DEVICE_TOKEN) ?? "")
        
        return pushToken
    }
    
    static func getOSVersion() -> String! {
        let systemVersion = String(describing: UIDevice.current.systemVersion ?? "")
        
        return systemVersion
    }
    
    static func getRefferer() -> String {
        //  @TODO implementation
        return ""
    }
}

extension UIColor {
    static let mainColor = UIColor(red:1.00, green:0.70, blue:0.72, alpha:1.0)
}
