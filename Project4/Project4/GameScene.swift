//
//  GameScene.swift
//  Project4
//
//  Created by Will Keller on 10/16/19.
//  Copyright © 2019 Will Keller. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var player : SKSpriteNode?;
    let cam = SKCameraNode();
    
    override func didMove(to view: SKView) {
        self.player = self.childNode(withName: "player") as? SKSpriteNode;
        self.camera = cam;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self.view);
        //add 3 flags, 1 so you can only jump once
        if(location!.y < (self.view?.frame.height)!/2){
            player?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50));
        } else if(location!.x > (self.view?.frame.width)!/2){
            player?.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 0));
        } else if(location!.x < (self.view?.frame.width)!/2){
            player?.physicsBody?.applyImpulse(CGVector(dx: -20, dy: 0));
        }
    
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        cam.position = CGPoint(x: player!.position.x+500, y: player!.position.y+245);
    }
}
