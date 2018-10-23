//
//  ViewController.swift
//  TichuCounter
//
//  Created by Teodoro Gomes on 16/6/17.
//
//

import UIKit

class CounterViewController: UIViewController ,UITextFieldDelegate {

    
    
    
    
    
    
    @IBOutlet weak var test: UILabel!
    var effect:UIVisualEffect!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet var changeTeam: UIView!
    @IBOutlet weak var chtext2: UITextField!
    @IBOutlet weak var chtext1: UITextField!
    @IBOutlet weak var team1SLabel: UILabel!
    @IBOutlet weak var team2SLabel: UILabel!
    @IBOutlet weak var team1Score: UITextField!
    @IBOutlet weak var team2Score: UITextField!
    @IBOutlet var switches: [UISwitch]!
    @IBOutlet weak var team1Label: UILabel!
    @IBOutlet weak var team2Label: UILabel!
    var timer = Timer()

    var tichu = Int()
    var tichu2 = Int()
    var threedtouch = String()
    
    //MARK: Switches
    @IBAction func value_changed(_ sender: UISwitch) {
        for i in 0...9 {
            switches[i].isEnabled = true
        }
        //Team1 : Successful tichu or grand tichu or double win
        if switches[0].isOn || switches[4].isOn || switches[8].isOn{
            switches[1].isEnabled = false
            switches[5].isEnabled = false
            switches[9].isEnabled = false
            if switches[0].isOn{switches[4].isEnabled = false}
            else if switches[4].isOn { switches[0].isEnabled = false }
        }
    //Team2 : Successful tichu or grand tichu or double
        if switches[1].isOn || switches[5].isOn || switches[9].isOn
        {
            switches[0].isEnabled = false
            switches[4].isEnabled = false
            switches[8].isEnabled = false
            if switches[1].isOn{switches[5].isEnabled = false }
            else if switches[5].isOn {switches[1].isEnabled = false}
        }
      
    }
  
    //MARK : Score
    
    
    
    @IBAction func Score1Changed(_ sender: Any) {
        var temp2 = String()
        var temp = Int()
        if team1Score.text != "" {
             temp = Int(team1Score.text!)!
        }
       
        if temp > 125 {
            temp = 0
            team1Score.text = ""
        }
        else if temp < -25 {
            temp = 0
            team1Score.text = ""
        }
        if temp % 5 != 0 {
            temp = -1
        }
        if temp != -1 && team1Score.text != "" {
             temp2 = String(100 - temp)}
        else { temp2 = "" }
        
        team2Score.text = temp2

    }
    @IBAction func Score2Changed(_ sender: Any) {
        var temp = Int()
        var temp2 = String()
        if team2Score.text != "" {
            temp = Int(team2Score.text!)!
        }
        
        if temp > 125 {
            temp = 0
            team2Score.text = ""
        }
        else if temp < -25 {
            temp = 0
            team2Score.text = ""
        }
        if temp % 5 != 0 {
            temp = -1
            
        }
        if temp != -1 && team2Score.text != "" {
            temp2 = String(100 - temp)}
        else {temp2 = "" }
        
        team1Score.text = temp2
       
        
    }
    
    //MARK: Count 

    @IBAction func countButton(_ sender: Any) {
        
        //TICHU
        tichu = 0
        tichu2 = 0
        if switches[0].isOn {tichu += 100 }
        if switches[1].isOn {tichu2 += 100 }
        //Failed TICHU
        if switches[2].isOn {tichu += -100 }
        if switches[3].isOn {tichu2 += -100 }
        //GRAND TICHU
        if switches[4].isOn {tichu += 200 }
        if switches[5].isOn {tichu2 += 200 }
        //Double Win
        if  switches[8].isOn {tichu += 200 }
        if  switches[9].isOn {tichu2 += 200 }
        //Failed GRAND TICHU
        if switches[6].isOn {tichu += -200 }
        if switches[7].isOn {tichu2 += -200 }
       
        
        if (switches[8].isOn || switches[9].isOn) {     // IN CASE OF DOUBLE WIN
            team1SLabel.text = String(Int(team1SLabel.text!)! + tichu)
            team2SLabel.text = String(Int(team2SLabel.text!)! + tichu2)
        }
        else if (team1Score.text != "" && team2Score.text != "" && Int(team1Score.text!)! % 5 == 0 && Int(team2Score.text!)! % 5 == 0 ){
          team1SLabel.text = String(Int(team1SLabel.text!)! + Int(team1Score.text!)! + tichu)
        
          team2SLabel.text = String(Int(team2SLabel.text!)! + Int(team2Score.text!)! + tichu2)
            
            
        }
        else {
            let dialog = UIAlertController(title: "Error Input",message: "Please check your inputs",preferredStyle:
                UIAlertControllerStyle.alert)
            let defaultAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            dialog.addAction(defaultAction)
            present(dialog,animated: true,completion: nil)
        }
        team1Score.text = ""
        team2Score.text = ""
        //INIT SWITCHES
        for i in 0...9 {
            switches[i].isOn = false
            switches[i].isEnabled=true
        }
        
        //ALERT WINNER
        var winner = ""
        if Int(team1SLabel.text!)! >= 1000 {
            winner = team1Label.text!
        }
        if Int(team2SLabel.text!)! >= 1000 {
            winner = team2Label.text!
        }
        if winner != "" {
            let dialog = UIAlertController(title: "Game Over",message: winner + " is the winner",preferredStyle:
            UIAlertControllerStyle.alert)
            let defaultAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            dialog.addAction(defaultAction)
            present(dialog,animated: true,completion: nil)
        }
        

    }
    
    
    
    @IBOutlet weak var countbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tichu = 0
        tichu2 = 0
        
        
        // Do any additional setup after loading the view, typically from a nib.
        team1Score.keyboardType = UIKeyboardType.numberPad
        team2Score.keyboardType = UIKeyboardType.numberPad
        team1Score.delegate = self
        team2Score.delegate = self
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "camera_icon"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 4)
        button.frame = CGRect(x: CGFloat(team1Score.frame.size.width - 40), y: CGFloat(2), width: CGFloat(6), height: CGFloat(14))
        button.tag = 1
        button.addTarget(self, action: #selector(counterAR), for: .touchUpInside)
        team1Score.rightView = button
        team1Score.rightViewMode = .unlessEditing
        
        let button2 = UIButton(type: .custom)
        button2.tag = 2
        button2.setImage(UIImage(named: "camera_icon"), for: .normal)
        button2.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 4)
        button2.frame = CGRect(x: CGFloat(team2Score.frame.size.width - 40), y: CGFloat(2), width: CGFloat(6), height: CGFloat(14))
        button2.addTarget(self, action: #selector(counterAR), for: .touchUpInside)
        team2Score.rightView = button2
        team2Score.rightViewMode = .unlessEditing
//
        
    }
    
    
    @objc
    func counterAR(sender:UIButton){
        print(sender.tag)
    }
    //Methods For blur and displaying second view for changing team
    func animateIn() {
        visualEffectView.isHidden = false
         self.view.addSubview(changeTeam)
        changeTeam.center = self.view.center
       
        changeTeam.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        changeTeam.layer.cornerRadius = 12
        UIView.animate(withDuration: 0.4){
           
            self.changeTeam.alpha=1
            self.changeTeam.transform = CGAffineTransform.identity
        }
    }
    func animateOut() {
       visualEffectView.isHidden = true
        UIView.animate(withDuration: 0.3 , animations: {
            self.changeTeam.transform = CGAffineTransform.init(scaleX: 2, y: 2)
            self.changeTeam.alpha = 0
            
        }) { (success:Bool) in
            self.changeTeam.removeFromSuperview()
        }
    }
    
    @IBAction func changeView(_ sender: Any) {
        animateIn()
    }
    @IBAction func backView(_ sender: UIButton) {
        if chtext1.text != "" { team1Label.text = chtext1.text}
        else{
            team1Label.text = "Ομάδα 1"}
        if chtext2.text != "" { team2Label.text = chtext2.text}
        else{
            team2Label.text = "Ομάδα 2"}
        animateOut()
    }
    
    
    //Reset Game
    
    @IBAction func reset(_ sender: Any) {
        
        team1Score.text = ""
        team2Score.text = ""
        team1SLabel.text="0"
        team2SLabel.text="0"
        for i in 0...9 {
            switches[i].isEnabled = true
            switches[i].isOn = false
        }
        
    }
    
    

    //KEYBOARD
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        team1Score.resignFirstResponder()
        team2Score.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

