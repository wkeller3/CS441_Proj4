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
        static let FINISH = ContactBits(rawValue: 1 << 5)
    }
    
    private var player : SKSpriteNode?;
    private var floor : SKSpriteNode?;
    private var coin1 : SKSpriteNode?;
    private var coin2 : SKSpriteNode?;
    private var coin3 : SKSpriteNode?;
    private var coin4 : SKSpriteNode?;
    private var coin5 : SKSpriteNode?;
    private var coin6 : SKSpriteNode?;
    private var coin7 : SKSpriteNode?;
    private var coin8 : SKSpriteNode?;
    private var coin9 : SKSpriteNode?;
    private var coin10 : SKSpriteNode?;
    private var coin11 : SKSpriteNode?;
    private var coin12 : SKSpriteNode?;
    private var coin13 : SKSpriteNode?;
    private var coin14 : SKSpriteNode?;
    private var coin15 : SKSpriteNode?;
    private var coin16 : SKSpriteNode?;
    private var coin17 : SKSpriteNode?;
    private var coin18 : SKSpriteNode?;
    private var coin19 : SKSpriteNode?;
    private var coin20 : SKSpriteNode?;
    private var wall1 : SKSpriteNode?;
    private var monster1 : SKSpriteNode?;
    private var monster2 : SKSpriteNode?;
    private var monster3 : SKSpriteNode?;
    private var monster4 : SKSpriteNode?;
    private var monster5 : SKSpriteNode?;
    private var monster6 : SKSpriteNode?;
    private var stair1 : SKSpriteNode?;
    private var stair2 : SKSpriteNode?;
    private var stair3 : SKSpriteNode?;
    private var stair4 : SKSpriteNode?;
    private var stair5 : SKSpriteNode?;
    private var stair6 : SKSpriteNode?;
    private var stair7 : SKSpriteNode?;
    private var stair8 : SKSpriteNode?;
    private var stair9 : SKSpriteNode?;
    private var stair10 : SKSpriteNode?;
    private var platform1: SKSpriteNode?;
    private var platform2: SKSpriteNode?;
    private var platform3: SKSpriteNode?;
    private var platform4: SKSpriteNode?;
    private var platform5: SKSpriteNode?;
    private var platform6: SKSpriteNode?;
    private var finish: SKSpriteNode?;
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
        Score.scoreInt = 0;
        score = SKLabelNode(text: String(Score.scoreInt));
        score?.position = CGPoint(x: cam.position.x+650, y: cam.position.y+350);
        addChild(score!);
        setUpNodes();
    }
    
    func setUpNodes(){
        player?.physicsBody?.categoryBitMask = UInt32(ContactBits.PLAYER.rawValue);
        player?.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.WALL.rawValue | ContactBits.GROUND.rawValue | ContactBits.MONSTER.rawValue);
        player?.physicsBody?.contactTestBitMask = UInt32(ContactBits.COIN.rawValue | ContactBits.GROUND.rawValue | ContactBits.MONSTER.rawValue | ContactBits.FINISH.rawValue);
        
        floor?.physicsBody?.categoryBitMask = UInt32(ContactBits.GROUND.rawValue);
        floor?.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.MONSTER.rawValue);
        floor?.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
        
        coin1 = self.childNode(withName: "coin1") as? SKSpriteNode;
        setCoin(node: coin1!);
        coin2 = self.childNode(withName: "coin2") as? SKSpriteNode;
        setCoin(node: coin2!);
        coin3 = self.childNode(withName: "coin3") as? SKSpriteNode;
        setCoin(node: coin3!);
        coin4 = self.childNode(withName: "coin4") as? SKSpriteNode;
        setCoin(node: coin4!);
        coin5 = self.childNode(withName: "coin5") as? SKSpriteNode;
        setCoin(node: coin5!);
        coin6 = self.childNode(withName: "coin6") as? SKSpriteNode;
        setCoin(node: coin6!);
        coin7 = self.childNode(withName: "coin7") as? SKSpriteNode;
        setCoin(node: coin7!);
        coin8 = self.childNode(withName: "coin8") as? SKSpriteNode;
        setCoin(node: coin8!);
        coin9 = self.childNode(withName: "coin9") as? SKSpriteNode;
        setCoin(node: coin9!);
        coin10 = self.childNode(withName: "coin10") as? SKSpriteNode;
        setCoin(node: coin10!);
        coin11 = self.childNode(withName: "coin11") as? SKSpriteNode;
        setCoin(node: coin11!);
        coin12 = self.childNode(withName: "coin12") as? SKSpriteNode;
        setCoin(node: coin12!);
        coin13 = self.childNode(withName: "coin13") as? SKSpriteNode;
        setCoin(node: coin13!);
        coin14 = self.childNode(withName: "coin14") as? SKSpriteNode;
        setCoin(node: coin14!);
        coin15 = self.childNode(withName: "coin15") as? SKSpriteNode;
        setCoin(node: coin15!);
        coin16 = self.childNode(withName: "coin16") as? SKSpriteNode;
        setCoin(node: coin16!);
        coin17 = self.childNode(withName: "coin17") as? SKSpriteNode;
        setCoin(node: coin17!);
        coin18 = self.childNode(withName: "coin18") as? SKSpriteNode;
        setCoin(node: coin18!);
        coin19 = self.childNode(withName: "coin19") as? SKSpriteNode;
        setCoin(node: coin19!);
        coin20 = self.childNode(withName: "coin20") as? SKSpriteNode;
        setCoin(node: coin20!);
        
        wall1 = self.childNode(withName: "wall1") as? SKSpriteNode;
        wall1?.physicsBody?.categoryBitMask = UInt32(ContactBits.WALL.rawValue);
        wall1?.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.MONSTER.rawValue);
        wall1?.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
        
        monster1 = self.childNode(withName: "monster1") as? SKSpriteNode;
        setMonster(node: monster1!);
        monster2 = self.childNode(withName: "monster2") as? SKSpriteNode;
        setMonster(node: monster2!);
        monster3 = self.childNode(withName: "monster3") as? SKSpriteNode;
        setMonster(node: monster3!);
        monster4 = self.childNode(withName: "monster4") as? SKSpriteNode;
        setMonster(node: monster4!);
        monster5 = self.childNode(withName: "monster5") as? SKSpriteNode;
        setMonster(node: monster5!);
        monster6 = self.childNode(withName: "monster6") as? SKSpriteNode;
        setMonster(node: monster6!);
        
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
        stair6 = self.childNode(withName: "stair6") as? SKSpriteNode;
        setStair(node: stair6!);
        stair7 = self.childNode(withName: "stair7") as? SKSpriteNode;
        setStair(node: stair7!);
        stair8 = self.childNode(withName: "stair8") as? SKSpriteNode;
        setStair(node: stair8!);
        stair9 = self.childNode(withName: "stair9") as? SKSpriteNode;
        setStair(node: stair9!);
        stair10 = self.childNode(withName: "stair10") as? SKSpriteNode;
        setStair(node: stair10!);
        
        platform1 = self.childNode(withName: "platform1") as? SKSpriteNode;
        setPlatform(node: platform1!);
        platform2 = self.childNode(withName: "platform2") as? SKSpriteNode;
        setPlatform(node: platform2!);
        platform3 = self.childNode(withName: "platform3") as? SKSpriteNode;
        setPlatform(node: platform3!);
        platform4 = self.childNode(withName: "platform4") as? SKSpriteNode;
        setPlatform(node: platform4!);
        platform5 = self.childNode(withName: "platform5") as? SKSpriteNode;
        setPlatform(node: platform5!);
        platform6 = self.childNode(withName: "platform6") as? SKSpriteNode;
        setPlatform(node: platform6!);
        
        finish = self.childNode(withName: "finish") as? SKSpriteNode;
        finish?.physicsBody?.categoryBitMask = UInt32(ContactBits.FINISH.rawValue);
        finish?.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue);
        finish?.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
    }
    
    func setPlatform(node : SKSpriteNode){
        node.physicsBody?.categoryBitMask = UInt32(ContactBits.GROUND.rawValue);
        node.physicsBody?.collisionBitMask = UInt32(ContactBits.PLAYER.rawValue | ContactBits.MONSTER.rawValue);
        node.physicsBody?.contactTestBitMask = UInt32(ContactBits.PLAYER.rawValue);
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
            completeLevel(node: contact.bodyB.node as! SKSpriteNode);
        }else if(contact.bodyB.node == player){
            jump = canJump(node: contact.bodyA.node as! SKSpriteNode);
            updateScore(node: contact.bodyA.node as! SKSpriteNode);
            gameOver(node: contact.bodyA.node as! SKSpriteNode);
            completeLevel(node: contact.bodyA.node as! SKSpriteNode);
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
    
    func completeLevel(node : SKSpriteNode){
        if(node.physicsBody?.categoryBitMask == UInt32(ContactBits.FINISH.rawValue)){
            Score.scoreInt += 5;
            self.removeAllActions();
            self.removeAllChildren();
            self.removeFromParent();
            let endScene:SKScene = GameOver(fileNamed: "LevelEnd")!;
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
