//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Kashfa Talukdar on 20/01/2016.
//  Copyright © 2016 Kashfa Talukdar. All rights reserved.
//

import UIKit
import AVFoundation

enum Operation :String {
    case Divide = "/"
    case Multiply = "*"
    case Add = "+"
    case Subtract = "-"
    case Empty = ""
    
}

var currentNum = ""
var leftVal = ""
var rightVal = ""
var currentOperation : Operation = Operation.Empty
var answer = ""
var btnSound : AVAudioPlayer!

class ViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let path = NSBundle.mainBundle().pathForResource("btn", ofType:"wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
      try   btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()

    } catch let err as NSError {
    print(err.debugDescription)
    }
    }
    
    @IBAction func numPressed(btn : UIButton!){
        playSound()
        currentNum += "\(btn.tag)"
        answerLabel.text = currentNum
    }

    @IBAction func divideBtn(sender: AnyObject) {
        operationPressed(Operation.Divide)
    }
    @IBAction func multiplyBtn(sender: AnyObject) {
        operationPressed(Operation.Multiply)
    }
    @IBAction func addBtn(sender: AnyObject) {
        operationPressed(Operation.Add)
    }
    @IBAction func subtractBtn(sender: AnyObject) {
        operationPressed(Operation.Subtract)
    }
    @IBAction func equalsBtn(sender: AnyObject) {
        operationPressed(currentOperation)
        
    }
    @IBAction func clearBtn(sender: AnyObject) {
        playSound()
        currentNum = ""
        currentOperation = Operation.Empty
        answerLabel.text = ""
    }
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
           
        }
         btnSound.play()
    }
    
    func operationPressed(op:Operation){
         playSound()
        if currentOperation != Operation.Empty{
            if currentNum != "" {
                rightVal = currentNum
                currentNum = ""

                if currentOperation == Operation.Divide{
                    answer = "\(Double(leftVal)! / Double(rightVal)!)"
                }
                else if currentOperation == Operation.Multiply{
                    answer = "\(Double(leftVal)! * Double(rightVal)!)"
                }
                else if currentOperation == Operation.Add{
                    answer = "\(Double(leftVal)! + Double(rightVal)!)"
                }
                else if currentOperation == Operation.Subtract{
                    answer = "\(Double(leftVal)! - Double(rightVal)!)"
                }
                answerLabel.text = answer
                leftVal = answer
                
            }
            
            currentOperation = op
        }else{
            leftVal = currentNum
            currentNum = ""
            currentOperation = op
        }
    
    }
    
}

