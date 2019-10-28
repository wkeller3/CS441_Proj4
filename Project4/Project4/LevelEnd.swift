//
//  LevelEnd.swift
//  Project4
//
//  Created by Will Keller on 10/27/19.
//  Copyright © 2019 Will Keller. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class LevelEnd : SKScene, UITextFieldDelegate{
    
    var score:SKLabelNode?;
    var text:UITextField?;
    var submit:UIButton?;
    
    override func didMove(to view: SKView) {
        score = self.childNode(withName: "score") as? SKLabelNode;
        score!.text = "Score: " + String(Score.scoreInt);
        text = UITextField(frame: CGRect(x: 400, y: 300, width: 100, height: 30));
        text?.placeholder = "Enter Name";
        text?.backgroundColor = UIColor.white;
        text?.textAlignment = NSTextAlignment.center;
        text?.delegate = self;
        self.view?.addSubview(text!);
        
        submit = UIButton(frame: CGRect(x: 550, y: 300, width: 100, height: 30));
        submit?.setTitle("Submit", for: .normal);
        submit?.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        self.view?.addSubview(submit!);
        
    }
    
    @objc func buttonClicked(_ sender: AnyObject?) {
        HighScores.names.append(text!.text!);
        HighScores.highscores.append(Score.scoreInt);
        
        self.view?.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder();
        return true;
    }
    
}

