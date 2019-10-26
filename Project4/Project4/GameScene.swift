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
    
    struct ContactBits : OptionSet{
        let rawValue: Int
        
        static let GROUND = ContactBits(rawValue: 1 << 0)
        static let PLAYER = ContactBits(rawValue: 1 << 1)
        static let COIN = ContactBits(rawValue: 1 << 2)
        static let WALL = ContactBits(rawValue: 1 << 3)
        static let MONSTER = ContactBits(rawValue: 1 << 4)
    }
    
    private var player : SKSpriteNode?;
    private var floor : SKSpriteNode?;
    private var coin1 : SKSpriteNode?;
    private var coin2 : SKSpriteNode?;
    private var wall1 : SKSpriteNode?;
    private var monster1 : SKSpriteNode?;
    private var stair1 : SKSpriteNode?;
    private var stair2 : SKSpriteNode?;
    private var stair3 : SKSpriteNode?;
    private var stair4 : SKSpriteNode?;
    private var stair5 : SKSpriteNode?;
    private var platform1: SKSpriteNode?;
    let cam = SKCameraNode();
    var flagR:Bool = false;
    var flagL:Bool = false;
    var jump:Bool = false;
    var score:SKLabelNode?;
    var scoreInt:Int = 0;
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self;
        self.player = self.childNode(withName: "player") as? SKSpriteNode;
        self.floor = self.childNode(withName: "floor") as? SKSpriteNode;
        //player!.physicsBody?.contactTestBitMask = player!.physicsBody!.collisionBitMask;
        self.camera = cam;
        score = SKLabelNode(text: String(scoreInt));
        score?.position = CGPoint(x: cam.position.x+650, y: cam.position.y+350);
        addChild(score!);
        setUpNodes();
    }
    
    func setUpNodes(){
        player?.physicsBody?.categoryBitMask = UInt32(ContactBits.PLAYER.rawValue);
        player?.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.WALL.rawValue | ContactBits.GROUND.rawValue | ContactBits.MONSTER.rawValue);
        player?.physicsBody?.contactTestBitMask = UInt32(ContactBits.COIN.rawValue | ContactBits.GROUND.rawValue | ContactBits.MONSTER.rawValue);
        
        floor?.physicsBody?.categoryBitMask = UInt32(ContactBits.GROUND.rawValue);
        floor?.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.MONSTER.rawValue);
        floor?.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
        
        coin1 = self.childNode(withName: "coin1") as? SKSpriteNode;
        coin1?.physicsBody?.categoryBitMask = UInt32(ContactBits.COIN.rawValue);
        coin1?.physicsBody?.collisionBitMask = 0;
        coin1?.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
        
        coin2 = self.childNode(withName: "coin2") as? SKSpriteNode;
        coin2?.physicsBody?.categoryBitMask = UInt32(ContactBits.COIN.rawValue);
        coin2?.physicsBody?.collisionBitMask = 0;
        coin2?.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
        
        wall1 = self.childNode(withName: "wall1") as? SKSpriteNode;
        wall1?.physicsBody?.categoryBitMask = UInt32(ContactBits.WALL.rawValue);
        wall1?.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.MONSTER.rawValue);
        wall1?.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
        
        monster1 = self.childNode(withName: "monster1") as? SKSpriteNode;
        monster1?.physicsBody?.categoryBitMask = UInt32(ContactBits.MONSTER.rawValue);
        monster1?.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.MONSTER.rawValue | ContactBits.WALL.rawValue);
        monster1?.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
        
        stair1 = self.childNode(withName: "stair1") as? SKSpriteNode;
        stair1?.physicsBody?.categoryBitMask = UInt32(ContactBits.GROUND.rawValue);
        stair1?.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.MONSTER.rawValue);
        stair1?.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
        
        stair2 = self.childNode(withName: "stair2") as? SKSpriteNode;
        stair2?.physicsBody?.categoryBitMask = UInt32(ContactBits.GROUND.rawValue);
        stair2?.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.MONSTER.rawValue);
        stair2?.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
        
        stair3 = self.childNode(withName: "stair3") as? SKSpriteNode;
        stair3?.physicsBody?.categoryBitMask = UInt32(ContactBits.GROUND.rawValue);
        stair3?.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.MONSTER.rawValue);
        stair3?.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
        
        stair4 = self.childNode(withName: "stair4") as? SKSpriteNode;
        stair4?.physicsBody?.categoryBitMask = UInt32(ContactBits.GROUND.rawValue);
        stair4?.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.MONSTER.rawValue);
        stair4?.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
        
        stair5 = self.childNode(withName: "stair5") as? SKSpriteNode;
        stair5?.physicsBody?.categoryBitMask = UInt32(ContactBits.GROUND.rawValue);
        stair5?.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.MONSTER.rawValue);
        stair5?.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
        
        platform1 = self.childNode(withName: "platform1") as? SKSpriteNode;
        platform1?.physicsBody?.categoryBitMask = UInt32(ContactBits.GROUND.rawValue);
        platform1?.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.MONSTER.rawValue);
        platform1?.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
    }
    
    func didBegin(_ contact: SKPhysicsContact){
//        if(contact.bodyA.node != self.childNode(withName: "wall") && contact.bodyB.node != self.childNode(withName: "wall")){
//            jump = true;
//        }
//        if((contact.bodyA.node == player && contact.bodyB.node == self.childNode(withName: "ball1")) || (contact.bodyB.node == player && contact.bodyA.node == self.childNode(withName: "ball1"))){
//            gameOver();
//        }

        if(contact.bodyA.node == player){
            jump = canJump(node: contact.bodyB.node as! SKSpriteNode);
            updateScore(node: contact.bodyB.node as! SKSpriteNode);
            gameOver(node: contact.bodyB.node as! SKSpriteNode);
        }else if(contact.bodyB.node == player){
            jump = canJump(node: contact.bodyA.node as! SKSpriteNode);
            updateScore(node: contact.bodyA.node as! SKSpriteNode);
            gameOver(node: contact.bodyA.node as! SKSpriteNode);
        }
    }
    
    func canJump(node: SKSpriteNode) -> Bool{
        if(node.physicsBody?.categoryBitMask == UInt32(ContactBits.GROUND.rawValue)){
            return true;
        } else if((player?.position.y)! < CGFloat(-344)){
            return true;
        }
        return false;
    }
    
    func updateScore(node : SKSpriteNode){
        if(node.physicsBody?.categoryBitMask == UInt32(ContactBits.COIN.rawValue)){
            scoreInt += 1;
            score?.text = String(scoreInt);
            node.removeFromParent();
        }
    }
    
    func gameOver(node : SKSpriteNode){
        //JUST CREATE A NEW SCENE AND TRANSITION INTO IT
        //MAYBE TRANSITION INTO LEADERBOARD? AND THEN HAVE A BUTTON TO RETURN TO MAIN MENU
        if(node.physicsBody?.categoryBitMask == UInt32(ContactBits.MONSTER.rawValue)){
            self.removeAllActions();
            self.removeAllChildren();
            self.removeFromParent();
            self.view?.presentScene(nil);
        }
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
            player?.physicsBody?.applyImpulse(CGVector(dx: 2, dy: 0));
        } else if(flagL){
            player?.physicsBody?.applyImpulse(CGVector(dx: -2, dy: 0));
        }
        cam.position = CGPoint(x: player!.position.x+500, y: player!.position.y+245);
        score?.position = CGPoint(x: cam.position.x+650, y: cam.position.y+350);
    }
}
