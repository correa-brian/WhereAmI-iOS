//
//  WAQuestionViewController.swift
//  WhereAmI
//
//  Created by Brian Correa on 4/27/16.
//  Copyright © 2016 milkshake-systems. All rights reserved.
//

import UIKit

class WAQuestionViewController: WAViewController {
    
    var question: WAQuestion!
    var questionImage: UIImageView!
    var buttons = Array<UIButton>()

    override func loadView() {
        
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.lightGrayColor()
        
        let dimen = frame.size.width
        self.questionImage = UIImageView(frame: CGRect(x: 0, y: 0, width: dimen, height: dimen))
        self.questionImage.image = self.question.imageData
        view.addSubview(questionImage)
        
        let padding = CGFloat(18)
        var y = dimen + padding
        let height = CGFloat(44)
        let width = dimen-2*padding
        let offScreen = frame.size.height
        let white = UIColor.whiteColor()
        
        let answerIndex = Int(self.randomNumber(4))
        
        var options = Array<String>()
        options.appendContentsOf(self.question.options)
        options.insert("answer", atIndex: answerIndex)
        
        for i in 0..<4 {

            let btn = UIButton(type: .Custom)
            btn.frame = CGRect(x: padding, y: offScreen, width: width, height: height)
            btn.tag = Int(y)

            btn.layer.borderColor = white.CGColor
            btn.layer.borderWidth = 2.0
            btn.layer.cornerRadius = 0.5*height
            btn.layer.masksToBounds = true
            btn.setTitleColor(white, forState: .Normal)
            let text = (i == answerIndex) ? self.question.answer : options[i]
            
            btn.setTitle(text, forState: .Normal)
            btn.addTarget(self, action: #selector(WAQuestionViewController.selectOption(_:)), forControlEvents: .TouchUpInside)
            
            view.addSubview(btn)
            self.buttons.append(btn)
            y += btn.frame.size.height+padding
        }
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0..<self.buttons.count {
            
//            UIView.animateWithDuration(1.25,
//                                       delay: 0,
//                                       options: .CurveEaseInOut,
//                                       animations: {
//                                        let btn = self.buttons[i]
//                                        var btnFrame = btn.frame
//                                        btnFrame.origin.y = CGFloat(btn.tag)
//                                        btn.frame = btnFrame
//                
//                },
//                                       completion: nil)
            UIView.animateWithDuration(1.35,
                                       delay: (0.5+Double(i)*0.1),
                                       usingSpringWithDamping: 0.5,
                                       initialSpringVelocity: 0.0,
                                       options: .CurveEaseInOut,
                                       animations: {
                                        let btn = self.buttons[i]
                                        var btnFrame = btn.frame
                                        btnFrame.origin.y = CGFloat(btn.tag)
                                        btn.frame = btnFrame
                },
                                       completion: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
    }
    
    func randomNumber(max: Int) -> UInt32 {
        
        let i = arc4random() % UInt32(max)
//        print("Random Number: \(i)")
        return i
    }
    
    func selectOption(btn: UIButton){
        
        let selectedOption = btn.titleLabel!.text!
        
        if (selectedOption == self.question.answer){
    
            print("Correct")
            self.question.status = 1
        }
            
        else {
            print("Incorrect")
            self.question.status = 2
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
