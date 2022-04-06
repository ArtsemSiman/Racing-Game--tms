//
//  UserDefaults.swift
//  Racing game
//
//  Created by Артём Симан on 1.04.22.
//

import Foundation
import UIKit

class Settings {
    public static var shared = Settings()
    
    private init() {}
    
    var userName: String {
        get {
            UserDefaults.standard.string(forKey: UserKeys.userName.rawValue) ?? "User"
        }
        set (newName) {
            
            UserDefaults.standard.set(newName, forKey: UserKeys.userName.rawValue)
            
        }
    }
    
    
    var hindrance: Hindrance {
        get {
           let stringValue = UserDefaults.standard.string(forKey: UserKeys.hindrance.rawValue) ?? ""
            return Hindrance(rawValue: stringValue) ?? Hindrance.tree
        }
        set (newHindrance) {
            
            UserDefaults.standard.set(newHindrance.rawValue, forKey: UserKeys.hindrance.rawValue)
            
        }
    }
    
    var carColor: UIColor {
        get {
            guard let data = UserDefaults.standard.data(forKey: UserKeys.carColor.rawValue) else {return UIColor()}
            let decoder = JSONDecoder()
            let decodedColor = try? decoder.decode(CodableColor.self, from: data).color
            return decodedColor ?? UIColor()
            
        }
        set (newCarColor) {

            let encoder = JSONEncoder()
            let encodedData = try? encoder.encode(newCarColor.codable())
            UserDefaults.standard.set(encodedData, forKey: UserKeys.carColor.rawValue)

            
        }
    }
    
    var speed: Float {
        get {
            UserDefaults.standard.float(forKey: UserKeys.speed.rawValue)
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

