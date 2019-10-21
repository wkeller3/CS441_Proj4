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
    var flagR:Bool = false;
    var flagL:Bool = false;
    let playerCategory: UInt32 = 0x1 << 0;
    let groundCategory: UInt32 = 0x1 << 1;
    let platformCategory: UInt32 = 0x1 << 2;
    
    override func didMove(to view: SKView) {
        self.player = self.childNode(withName: "player") as? SKSpriteNode;
        player!.physicsBody!.contactTestBitMask = groundCategory | platformCategory;
        self.camera = cam;
    }
    
    func collisionBetweenG(player: SKNode, ground: SKNode){
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
    }
    
    func collisionBetweenP(player: SKNode, platform: SKNode){
        
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        if contact.bodyA.node?.name == "player"{
            
            if contact.bodyB.node?.name == "ground"{
                collisionBetweenG(player: contact.bodyA.node!, ground: contact.bodyB.node!)
            } else if contact.bodyB.node?.name == "platform"{
                collisionBetweenP(player: contact.bodyA.node!, platform: contact.bodyB.node!)
            }
            
        } else if contact.bodyB.node?.name == "player"{
            
            if contact.bodyA.node?.name == "ground"{
                collisionBetweenG(player: contact.bodyB.node!, ground: contact.bodyA.node!)
            } else if contact.bodyA.node?.name == "platform"{
                collisionBetweenP(player: contact.bodyB.node!, platform: contact.bodyA.node!)
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self.view);
        if(location!.y < (self.view?.frame.height)!/2){
            player?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50));
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
    }
}
