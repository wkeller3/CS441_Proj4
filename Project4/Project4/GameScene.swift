//
//  GameScene.swift
//  Project4
//
//  Created by Will Keller on 10/16/19.
//  Copyright © 2019 Will Keller. All rights reserved.
//

import SpriteKit
import GameplayKit

struct Score{
    static var scoreInt:Int = 0
}

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
    //var scoreInt:Int = 0;
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self;
        self.player = self.childNode(withName: "player") as? SKSpriteNode;
        self.floor = self.childNode(withName: "floor") as? SKSpriteNode;
        //player!.physicsBody?.contactTestBitMask = player!.physicsBody!.collisionBitMask;
        self.camera = cam;
        score = SKLabelNode(text: String(Score.scoreInt));
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
        setCoin(node: coin1!);
        
        coin2 = self.childNode(withName: "coin2") as? SKSpriteNode;
        setCoin(node: coin2!);
        
        wall1 = self.childNode(withName: "wall1") as? SKSpriteNode;
        wall1?.physicsBody?.categoryBitMask = UInt32(ContactBits.WALL.rawValue);
        wall1?.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.MONSTER.rawValue);
        wall1?.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
        
        monster1 = self.childNode(withName: "monster1") as? SKSpriteNode;
        setMonster(node: monster1!);
        
        stair1 = self.childNode(withName: "stair1") as? SKSpriteNode;
        setStair(node: stair1!);
        
        stair2 = self.childNode(withName: "stair2") as? SKSpriteNode;
        setStair(node: stair2!);
        
        stair3 = self.childNode(withName: "stair3") as? SKSpriteNode;
        setStair(node: stair3!);
        
        stair4 = self.childNode(withName: "stair4") as? SKSpriteNode;
        setStair(node: stair4!);
        
        stair5 = self.childNode(withName: "stair5") as? SKSpriteNode;
        setStair(node: stair5!);
        
        platform1 = self.childNode(withName: "platform1") as? SKSpriteNode;
        platform1?.physicsBody?.categoryBitMask = UInt32(ContactBits.GROUND.rawValue);
        platform1?.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.MONSTER.rawValue);
        platform1?.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
    }
    
    func setCoin(node : SKSpriteNode){
        node.physicsBody?.categoryBitMask = UInt32(ContactBits.COIN.rawValue);
        node.physicsBody?.collisionBitMask = 0;
        node.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
    }
    
    func setStair(node : SKSpriteNode){
        node.physicsBody?.categoryBitMask = UInt32(ContactBits.GROUND.rawValue);
        node.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.MONSTER.rawValue);
        node.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
    }
    
    func setMonster(node : SKSpriteNode){
        node.physicsBody?.categoryBitMask = UInt32(ContactBits.MONSTER.rawValue);
        node.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.MONSTER.rawValue | ContactBits.WALL.rawValue);
        node.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
    }
    
    func didBegin(_ contact: SKPhysicsContact){

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
            Score.scoreInt += 1;
            score?.text = String(Score.scoreInt);
            node.removeFromParent();
        }
    }
    
    func gameOver(node : SKSpriteNode){
        if(node.physicsBody?.categoryBitMask == UInt32(ContactBits.MONSTER.rawValue)){
            self.removeAllActions();
            self.removeAllChildren();
            self.removeFromParent();
            let endScene:SKScene = GameOver(fileNamed: "GameOver")!;
            self.view?.presentScene(endScene, transition: SKTransition.fade(withDuration: 1));
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
