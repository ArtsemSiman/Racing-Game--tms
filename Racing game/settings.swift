//
//  UserDefaults.swift
//  Racing game
//
//  Created by Артём Симан on 1.04.22.
//

import Foundation

class settings {
    public static var shared = settings()
    
    private init() {}
    
    var userName: String {
        get {
            UserDefaults.standard.string(forKey: UserKeys.userName.rawValue) ?? "User"
        }
        set (newName) {
            
            UserDefaults.standard.set(newName, forKey: UserKeys.userName.rawValue)
            
        }
    }
    
    
    var hindrance: String {
        get {
            UserDefaults.standard.string(forKey: UserKeys.hindrance.rawValue) ?? "Hindrance"
        }
        set (newHindrance) {
            
            UserDefaults.standard.set(newHindrance, forKey: UserKeys.hindrance.rawValue)
            
        }
    }
    
//        var carColor: Int {
//            get {
//                UserDefaults.standard.integer(forKey: UserKeys.carColor.rawValue)
//            }
//            set (newCarColor) {
//
//                UserDefaults.standard.set(newCarColor.encode(with:), forKey: UserKeys.carColor.rawValue)
//
//            }
//        }
    
    var speed: Int {
        get {
            UserDefaults.standard.integer(forKey: UserKeys.speed.rawValue)
        }
        set (newSpeed) {
            
            UserDefaults.standard.set(newSpeed, forKey: UserKeys.speed.rawValue)
            
        }
    }
    
    
    
    private enum UserKeys: String {
        case userName
        case hindrance
        case carColor
        case speed
    }
}

