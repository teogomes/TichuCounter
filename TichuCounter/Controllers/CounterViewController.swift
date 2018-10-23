//
//  ViewController.swift
//  TichuCounter
//
//  Created by Teodoro Gomes on 16/6/17.
//
//

import UIKit

class CounterViewController: UIViewController ,UITextFieldDelegate {

    
    
    
    
    
    
    @IBOutlet weak var blueProgress: UIProgressView!
    @IBOutlet weak var redProgress: UIProgressView!
    @IBOutlet weak var gapLabel: UILabel!
    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var targetText: UITextField!
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
    var buttonTag = 0
    var target = 1000
    var tichu = Int()
    var tichu2 = Int()
    var threedtouch = String()
    var prev1 = 0
    var prev2 = 0
    
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
        
        //Team1 1:tichu 2:failedTichu
        if switches[0].isOn && switches[2].isOn {
            switches[6].isEnabled = false
        }
        //Team2 1:tichu 2:failedTichu
        if switches[1].isOn && switches[3].isOn {
            switches[7].isEnabled = false
        }
        
        //Team1 grandtichu winned and failed
        if switches[4].isOn && switches[6].isOn {
            switches[2].isEnabled = false
        }
        //Team2 grandtichu winned and failed
        if switches[5].isOn && switches[7].isOn {
            switches[3].isEnabled = false
        }
        
        //Team1 failed tichu and grand tichu
        if switches[2].isOn && switches[4].isOn {
            switches[6].isEnabled = false
        }
        //Team2 failed tichu and grand tichu
        if switches[3].isOn && switches[5].isOn {
            switches[7].isEnabled = false
        }
        
        //Team1 failed tichu failed grand tichu
        if switches[2].isOn && switches[6].isOn {
            switches[0].isEnabled = false
            switches[4].isEnabled = false
            switches[8].isEnabled = false
        }
        //Team2 failed tichu failed grand tichu
        if switches[3].isOn && switches[7].isOn {
            switches[1].isEnabled = false
            switches[5].isEnabled = false
            switches[9].isEnabled = false
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
    func incrementLabel(startValue:Int , endValue: Int , textbox:UILabel,which:Int) {
        let duration: Double = 0.3 //seconds
        
        if startValue < endValue {
            DispatchQueue.global().async {
                for i in startValue ..< (endValue + 1) {
                    let sleepTime = UInt32(duration * 10000.0)
                    usleep(sleepTime)
                    DispatchQueue.main.async {
                        textbox.text = "\(i)"
                    }
                }
            }
        }else if endValue < startValue{
            DispatchQueue.global().async {
                for i in stride(from: startValue, through: endValue, by: -1) {
                    let sleepTime = UInt32(duration * 10000.0)
                    usleep(sleepTime)
                    DispatchQueue.main.async {
                        textbox.text = "\(i)"
                    }
                }
            }
        }
        
        if which == 1 {
            redProgress.setProgress(Float(endValue) / Float(target), animated: true)
        }else{
             blueProgress.setProgress(Float(endValue) / Float(target), animated: true)
        }
        
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
       
        //LETS OPTIMIZE
        
        let strValue1 = Int(team1SLabel.text!)!
        var endValue1 = 0
        let strValue2 =  Int(team2SLabel.text!)!
        var endValue2 = 0
        var write = false
        
        if (switches[8].isOn || switches[9].isOn) {     // IN CASE OF DOUBLE WIN
            endValue1 = Int(team1SLabel.text!)! + tichu
            endValue2 = Int(team2SLabel.text!)! + tichu2
            write = true
        }
        else if (team1Score.text != "" && team2Score.text != "" && Int(team1Score.text!)! % 5 == 0 && Int(team2Score.text!)! % 5 == 0 ){
            endValue1 = Int(team1SLabel.text!)! + Int(team1Score.text!)! + tichu
            endValue2 = Int(team2SLabel.text!)! + Int(team2Score.text!)! + tichu2
            write = true
            
        }
        else {
            let dialog = UIAlertController(title: "Error Input",message: "Please check your inputs",preferredStyle:
                UIAlertControllerStyle.alert)
            let defaultAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            dialog.addAction(defaultAction)
            present(dialog,animated: true,completion: nil)
        }
        
        if write {
            prev1 = strValue1
            prev2 = strValue2
            
            incrementLabel(startValue: strValue1, endValue: endValue1, textbox: team1SLabel,which: 1)
            incrementLabel(startValue: strValue2, endValue: endValue2, textbox: team2SLabel,which: 2)
            //Round
            round.text = String(Int(round.text!)! + 1)
            if endValue1 > endValue2 {
                gapLabel.text = String(endValue1 - endValue2)
                gapLabel.textColor = UIColor.red
            }else if endValue1 < endValue2 {
                gapLabel.text = String(endValue2 - endValue1)
                gapLabel.textColor = UIColor.blue
            }else{
                gapLabel.text = "0"
                gapLabel.textColor = UIColor.black
            }
            
            
            
        }
       
        
        write = false
        team1Score.text = ""
        team2Score.text = ""
        //INIT SWITCHES
        for i in 0...9 {
            switches[i].isOn = false
            switches[i].isEnabled=true
        }
        
        
        //ALERT WINNER
        var winner = ""
        if endValue1 >= target {
            winner = team1Label.text!
        }
        if endValue2 >= target {
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
        
        //ProgressBars
        redProgress.transform = redProgress.transform.scaledBy(x: 1, y: 3)
        blueProgress.transform = blueProgress.transform.scaledBy(x: 1, y: 3)
        
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

        targetText.text = String(target)
        
    }
    
    
    @objc
    func counterAR(sender:UIButton){
        performSegue(withIdentifier: "arSegue", sender: self)
        buttonTag = sender.tag
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
        if(Int(targetText.text!) ?? 0 > 100) {
            target = Int(targetText.text!) ?? 1000
        }
        
        redProgress.progress = Float(team1SLabel.text!)! / Float(target)
        blueProgress.progress = Float(team2SLabel.text!)! / Float(target)
        
        animateOut()
    }
    
    
    //Reset Game
    
    @IBAction func reset(_ sender: Any) {
        
//        redProgress.progress = 0.0
//        blueProgress.progress = 0.0
//        team1Score.text = ""
//        team2Score.text = ""
//        team1SLabel.text="0"
//        team2SLabel.text="0"
//        for i in 0...9 {
//            switches[i].isEnabled = true
//            switches[i].isOn = false
//        }
        incrementLabel(startValue: Int(team1SLabel.text!)!, endValue: prev1, textbox: team1SLabel,which: 1)
        incrementLabel(startValue: Int(team2SLabel.text!)!, endValue: prev2, textbox: team2SLabel,which: 2)
        
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
    
    

    @IBAction func changeViewController(_ sender: UIScreenEdgePanGestureRecognizer) {
        if sender.edges == UIRectEdge.left {
            let vc = ScoresTableViewController() //change this to your class name
           
            self.navigationController?.present(vc, animated: true, completion: nil)
            
        }
    }
    
}

