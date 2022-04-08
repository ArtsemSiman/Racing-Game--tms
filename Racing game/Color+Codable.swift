//
//  Color+Codable.swift
//  Racing game
//
//  Created by Артём Симан on 4.04.22.
//

import UIKit


public struct CodableColor {
    let color: UIColor
}



extension CodableColor: Encodable {

    public func encode(to encoder: Encoder) throws {
        let nsCoder = NSKeyedArchiver(requiringSecureCoding: true)
        color.encode(with: nsCoder)
        var container = encoder.unkeyedContainer()
        try container.encode(nsCoder.encodedData)
    }
}



extension CodableColor: Decodable {

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let decodedData = try container.decode(Data.self)
        let nsCoder = try NSKeyedUnarchiver(forReadingFrom: decodedData)
        self.color = try UIColor(coder: nsCoder).unsafelyUnwrapped
      
    }
}



public extension UIColor {
    func codable() -> CodableColor {
        return CodableColor(color: self)
    }
}
