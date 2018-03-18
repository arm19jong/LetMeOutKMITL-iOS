//
//  UserSP.swift
//  LetMeOutKMITL
//
//  Created by suchaj jongprasit on 3/18/2561 BE.
//  Copyright © 2561 km. All rights reserved.
//
import UIKit
class UserSP{
    static let sharedInstance = UserSP()
    
    func setUid(userDefaults:UserDefaults, uid:String){
        userDefaults.set(uid, forKey: "UID")
    }
    
    func getUid(userDefaults:UserDefaults)->String{
        let uid = userDefaults.string(forKey: "UID") ?? ""
        return (uid)
    }
    
    func setEmail(email:String){
        
    }
    
    func getEmail()->String{
        return ("email")
    }
}
