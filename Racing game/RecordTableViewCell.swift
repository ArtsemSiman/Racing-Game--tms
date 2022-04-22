//
//  RecordTableViewCell.swift
//  Racing game
//
//  Created by Артём Симан on 22.04.22.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.name.text = String()
        self.score.text = String()
        self.date.text = String()
    }
}
