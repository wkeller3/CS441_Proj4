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
    
    let scrollView = UIScrollView();
    let contentView = UIView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLeaderboard();
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        //scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        
        contentView.addSubview(label1)
        label1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label1.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label1.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        
        contentView.addSubview(label2)
        label2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 25).isActive = true
        label2.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        label2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(label3)
        label3.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label3.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 500).isActive = true
        label3.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        label3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(label4)
        label4.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label4.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 1000).isActive = true
        label4.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        label4.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    func updateLeaderboard(){
        let size = HighScores.highscores.count;
        if(size > 3){
            let combined = zip(HighScores.highscores, HighScores.names).sorted(by: {$0.0 < $1.0});
            //print(combined);
            let sorted1 = combined.map {$0.0};
            let sorted2 = combined.map {$0.1};
            //print(sorted1);
            //print(sorted2);
            label2.text = "1. " + sorted2[size-1] + ": " + String(sorted1[size-1]);
            label3.text = "2. " + sorted2[size-2] + ": " + String(sorted1[size-2]);
            label4.text = "3. " + sorted2[size-3] + ": " + String(sorted1[size-3]);
        }
    }

    let label1: UILabel = {
        let label = UILabel()
        label.text = "High Scores";
        label.numberOfLines = 2
        label.font = label.font.withSize(CGFloat(110));
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   let label2: UILabel = {
        let label = UILabel()
        label.text = "1. " + HighScores.names[0] + ": " + String(HighScores.highscores[0]);
        label.numberOfLines = 1
        label.font = label.font.withSize(CGFloat(90));
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.text = "2. " + HighScores.names[1] + ": " + String(HighScores.highscores[1]);
        label.numberOfLines = 1
        label.font = label.font.withSize(CGFloat(90));
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label4: UILabel = {
        let label = UILabel()
        label.text = "3. " + HighScores.names[2] + ": " + String(HighScores.highscores[2]);
        label.numberOfLines = 1
        label.font = label.font.withSize(CGFloat(90));
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
