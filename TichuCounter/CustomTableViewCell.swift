//
//  CustomTableViewCell.swift
//  TichuCounter
//
//  Created by Teodoro Gomes on 24/10/2018.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var team2Points: UILabel!
    @IBOutlet weak var team1Points: UILabel!
    @IBOutlet weak var team1NewPoints: UILabel!
    @IBOutlet weak var team2NewPoints: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var tichu1Label: UILabel!
    @IBOutlet weak var tichu2Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        team1Points.adjustsFontSizeToFitWidth = true
         team2Points.adjustsFontSizeToFitWidth = true
        team1Points.minimumScaleFactor=0.5;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
