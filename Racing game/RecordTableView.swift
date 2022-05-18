//
//  RecordTableView.swift
//  Racing game
//
//  Created by Артём Симан on 21.04.22.
//

import UIKit
import FirebaseCrashlytics
import FirebaseAnalytics


class RecordTableView: UIViewController {
    
    
    @IBOutlet weak var recordTabel: UITableView!
    
    let userScoresArray: [RecordTable] = [
        RecordTable(userName: "a", userScore: 3, userDate: .now),
        RecordTable(userName: "d", userScore: 5, userDate: .now),
        RecordTable(userName: "f", userScore: 2, userDate: .now)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordTabel.dataSource = self
        recordTabel.delegate = self
        recordTabel.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "recordCell")
    }
}

extension RecordTableView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userScoresArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as? RecordTableViewCell
        else { return UITableViewCell() }
        let user = userScoresArray[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy HH:mm"
        dateFormatter.timeZone = TimeZone.current
        let stringDate = dateFormatter.string(from: user.userDate)
        
        cell.name.text = user.userName
        cell.date.text = stringDate
        cell.score.text = "\(user.userScore)"
        
        return cell
        
        let userInfo = [
          NSLocalizedDescriptionKey: NSLocalizedString("The request failed.", comment: ""),
          NSLocalizedFailureReasonErrorKey: NSLocalizedString("The response returned a 404.", comment: ""),
          NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Something wrong", comment: ""),
          "ProductID": "NO ID",
          "View": "MainView"
        ]

        let error = NSError.init(domain: NSCocoaErrorDomain,
                                 code: -1004,
                                 userInfo: userInfo)
        Crashlytics.crashlytics().record(error: error)
    }
}

