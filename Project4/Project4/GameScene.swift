//
//  GameScene.swift
//  Project4
//
//  Created by Will Keller on 10/16/19.
//  Copyright © 2019 Will Keller. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var player : SKSpriteNode?;
    private var floor : SKSpriteNode?;
    let cam = SKCameraNode();
    var flagR:Bool = false;
    var flagL:Bool = false;
    var jump:Bool = false;
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self;
        self.player = self.childNode(withName: "player") as? SKSpriteNode;
        self.floor = self.childNode(withName: "floor") as? SKSpriteNode;
        player!.physicsBody?.contactTestBitMask = player!.physicsBody!.collisionBitMask;
        self.camera = cam;
        
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        jump = true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self.view);
        if(location!.y < (self.view?.frame.height)!/2 && jump){
            player?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50));
            jump = false;
        } else if(location!.x > (self.view?.frame.width)!/2){
            flagR = true;
            //player?.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 0));
        } else if(location!.x < (self.view?.frame.width)!/2){
            flagL = true;
            //player?.physicsBody?.applyImpulse(CGVector(dx: -20, dy: 0));
        }
    
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        flagR = false;
        flagL = false;
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if(flagR){
            player?.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 0));
        } else if(flagL){
            player?.physicsBody?.applyImpulse(CGVector(dx: -5, dy: 0));
        }
        cam.position = CGPoint(x: player!.position.x+500, y: player!.position.y+245);
        if(player!.position.x > CGFloat(775)){
            floor?.removeFromParent();
            self.childNode(withName: "stair1")?.removeFromParent();
            self.childNode(withName: "stair2")?.removeFromParent();
            self.childNode(withName: "stair3")?.removeFromParent();
            self.childNode(withName: "stair4")?.removeFromParent();
            self.childNode(withName: "stair5")?.removeFromParent();
            self.childNode(withName: "stair6")?.removeFromParent();
            self.childNode(withName: "stair7")?.removeFromParent();
            self.childNode(withName: "stair8")?.removeFromParent();
        }
    }
}
