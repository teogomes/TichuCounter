//
//  secondViewController.swift
//  TichuCounter
//
//  Created by Teodoro Gomes on 16/6/17.

//
//

import UIKit

class secondViewController: UIViewController , UITextFieldDelegate , UINavigationControllerDelegate{

    
    @IBOutlet weak var textbox1: UITextField!
    @IBOutlet weak var textbox2: UITextField!
    
    
    
    
    
    

    @IBAction func okbutton(_ sender: Any) {
            performSegue(withIdentifier: "segue", sender: self)
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let firstview = segue.destination as! ViewController
//        if textbox1.text != ""{ firstview.name1 = textbox1.text!}
//        else{ firstview.name1 = "Ομάδα 1" }
//        if textbox2.text != ""{ firstview.name2 = textbox2.text!}
//        else{ firstview.name2 = "Ομάδα 2" }
 //       firstview.flag=true
        
        
 //   }
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            let DestViewController = segue.destination as! UINavigationController
            let targetController = DestViewController.topViewController as! CounterViewController
            targetController.team1Label.text = "hello from ReceiveVC !"
            print("works")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textbox1.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //KEYBOARD
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textbox1.resignFirstResponder()
        return true
    }
}
