//
//  TableTableViewController.swift
//  TichuCounter
//
//  Created by Teodoro Gomes on 23/10/2018.
//

import UIKit

class ScoresTableViewController: UIViewController , UITableViewDelegate ,UITableViewDataSource {
   
    

    @IBOutlet weak var tableView: UITableView!
    var pointsList:[points] = []
    var selectedIndex  = -1
    var cellHeight = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.separatorColor = UIColor.black
            print(pointsList)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(pointsList.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cellHeight = 20
      
        
        cell.team1Points.text = String(pointsList[indexPath.row].currentPoints1)
        cell.team2Points.text = String(pointsList[indexPath.row].currentPoints2)
        
        let prev1 = pointsList[indexPath.row].currentPoints1 - pointsList[indexPath.row].previousPoints1
        let prev2 = pointsList[indexPath.row].currentPoints2 - pointsList[indexPath.row].previousPoints2
        if prev1 >= 0 {
             cell.team1NewPoints.text = String("+ \(prev1)" )
        }else{
             cell.team1NewPoints.text = String(prev1)
        }
        if prev2 >= 0 {
            cell.team2NewPoints.text = String("+ \(prev2)" )
        }else{
            cell.team2NewPoints.text = String(prev2)
        }
       
        cell.tichu1Label.text = ""
        cell.tichu2Label.text = ""
        var count1 = 0
        var count2 = 0
        pointsList[indexPath.row].tichu1.forEach { (element) in
            cell.tichu1Label.text = cell.tichu1Label.text!  + element + "\n"
            count1 += 1
            
        }
        pointsList[indexPath.row].tichu2.forEach { (element) in
            cell.tichu2Label.text = cell.tichu2Label.text!  + element + "\n"
            count2 += 1
        }
                if count1 > count2 {
                    for _ in 0...count1{
                        cellHeight += 40
                    }
                }else{
                    for _ in 0...count2{
                        cellHeight += 40
                    }
                }

        cell.roundLabel.text = String("Round: \(pointsList[indexPath.row].round)")
        
                return(cell)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if  indexPath.row == selectedIndex {
            selectedIndex = -1
        }else{
            selectedIndex = indexPath.row
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == selectedIndex {
            return CGFloat(cellHeight)
        }else{
            return 40
        }
    }
    
   
    
    
    

    @IBAction func mainView(_ sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.ended{
            self.navigationController?.popViewController(animated: true)
        }
    }
}

