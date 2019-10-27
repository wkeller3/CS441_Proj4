//
//  LeaderboardViewController.swift
//  Project4
//
//  Created by Will Keller on 10/24/19.
//  Copyright © 2019 Will Keller. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class LeaderboardViewController: UIViewController {
    
    
    let labelOne: UILabel = {
        let label = UILabel()
        
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let labelTwo: UILabel = {
        let label = UILabel()
        
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelOne.text = HighScores.names[0] + ": " + String(HighScores.highscores[0]);
        labelTwo.text = HighScores.names[1] + ": " + String(HighScores.highscores[1]);
        
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        var scrollView: UIScrollView!
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 120, width: screenWidth, height: screenHeight))
        scrollView.contentSize = CGSize(width: screenWidth, height: 2000)
        scrollView.addSubview(labelOne)
        scrollView.addSubview(labelTwo)


        view.addSubview(labelOne)
        view.addSubview(labelTwo)
        view.addSubview(scrollView)

        // Visual Format Constraints
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": labelOne]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": labelOne]))

        // Using iOS 9 Constraints in order to place the label past the iPhone 7 view
        view.addConstraint(NSLayoutConstraint(item: labelTwo, attribute: .top, relatedBy: .equal, toItem: labelOne, attribute: .bottom, multiplier: 1, constant: screenHeight + 200))
        view.addConstraint(NSLayoutConstraint(item: labelTwo, attribute: .right, relatedBy: .equal, toItem: labelOne, attribute: .right, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: labelTwo, attribute: .left, relatedBy: .equal, toItem: labelOne, attribute: .left, multiplier: 1, constant: 0))

        }
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "Leaderboard") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
//    }
//
//    override var shouldAutorotate: Bool {
//        return true
//    }
//
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return .allButUpsideDown
//        } else {
//            return .all
//        }
//    }
//
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
}
