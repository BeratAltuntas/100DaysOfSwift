//
//  GameScene.swift
//  Project11
//
//  Created by BERAT ALTUNTAŞ on 22.02.2022.
//

import SpriteKit
class GameScene: SKScene, SKPhysicsContactDelegate {
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet{
            scoreLabel.text = "Score \(score)"
        }
    }
    var editLabel: SKLabelNode!
    var editingMode: Bool = false {
        didSet{
            if editingMode{
                editLabel.text = "Done"
            }
            else{
                editLabel.text = "Edit"
            }
        }
    }
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        MakeBouncer(at: CGPoint(x: 0, y: 0))
        MakeBouncer(at: CGPoint(x: 256, y: 0))
        MakeBouncer(at: CGPoint(x: 512, y: 0))
        MakeBouncer(at: CGPoint(x: 768, y: 0))
        MakeBouncer(at: CGPoint(x: 1024, y: 0))
        
        MakeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        MakeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        MakeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        MakeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        let objects = nodes(at: location)
        
        if objects.contains(editLabel){
            editingMode.toggle()
        }
        else{
            if editingMode{
                // create a box
                let size = CGSize(width: Int.random(in: 16...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                box.zRotation = CGFloat.random(in: 0...3)
                box.position = location
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.isDynamic = false
                addChild(box)
                
            }else{
                let ball = SKSpriteNode(imageNamed: "ballRed")
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
                ball.physicsBody?.restitution = 0.5 // sıçrama
                ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                
                ball.position = location
                ball.zPosition = 2
                ball.name = "ball"
                addChild(ball)
            }
        }
    }
    
    func MakeBouncer(at position : CGPoint){
        
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width/2)
        bouncer.physicsBody?.isDynamic = false
        bouncer.zPosition = 1
        addChild(bouncer)
    
    }
    
    func MakeSlot(at position: CGPoint, isGood: Bool){
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        var spin: SKAction
        
        if isGood{
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            spin = SKAction.rotate(byAngle: .pi, duration: 10)
            slotBase.name = "good"
        }
        else{
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            spin = SKAction.rotate(byAngle: -.pi, duration: 10)
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func Collision(between ball: SKNode, object: SKNode){
        if object.name == "good"{
            Destroy(ball: ball)
            score += 1
        }
        else if object.name == "bad" {
            Destroy(ball: ball)
            score -= 1
        }
    }
    
    func Destroy(ball:SKNode){
        ball.removeFromParent()
    }

    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        if nodeA.name == "ball"{
            Collision(between: nodeA, object: nodeB)
        }
        else if nodeB.name == "ball" {
            Collision(between: nodeB, object: nodeA)
        }
    }
    
    
    
}
