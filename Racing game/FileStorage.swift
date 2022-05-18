//
//  FileStorage.swift
//  Racing game
//
//  Created by Артём Симан on 1.04.22.
//

import Foundation
import UIKit
import FirebaseCrashlytics
import FirebaseAnalytics


class FileStorage {
    static func saveImage (_ image: UIImage?, withName filename: String) {
        
        guard let image = image,
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        
        let fileURL = URL(fileURLWithPath: filename, relativeTo: directoryURL).appendingPathExtension("png")
        
        guard let data = image.pngData() else { return }
        
        try? data.write(to: fileURL)
        
        let userInfo = [
          NSLocalizedDescriptionKey: NSLocalizedString("The request failed.", comment: ""),
          NSLocalizedFailureReasonErrorKey: NSLocalizedString("The response returned a 404.", comment: ""),
          NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Something wrong", comment: ""),
          "ProductID": "NO ID",
          "View": "MainView"
        ]

        let error = NSError.init(domain: NSCocoaErrorDomain,
                                 code: -1006,
                                 userInfo: userInfo)
        Crashlytics.crashlytics().record(error: error)
    }
    
    static func getImage(withName filename: String) ->UIImage? {
        guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileURL = URL(fileURLWithPath: filename, relativeTo: directoryURL).appendingPathExtension("png")
     
    
        guard let savedData = try? Data(contentsOf: fileURL) else { return nil }
         return UIImage(data: savedData) ?? UIImage()
        
        let userInfo = [
          NSLocalizedDescriptionKey: NSLocalizedString("The request failed.", comment: ""),
          NSLocalizedFailureReasonErrorKey: NSLocalizedString("The response returned a 404.", comment: ""),
          NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Something wrong", comment: ""),
          "ProductID": "NO ID",
          "View": "MainView"
        ]

        let error = NSError.init(domain: NSCocoaErrorDomain,
                                 code: -1007,
                                 userInfo: userInfo)
        Crashlytics.crashlytics().record(error: error)
    }
}
