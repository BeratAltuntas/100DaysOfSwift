//
//  GameScene.swift
//  Project17
//
//  Created by BERAT ALTUNTAŞ on 6.03.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var restartLabel: SKLabelNode!
    
    var lastScoreLabel: SKLabelNode!
    var highestScoreLabel: SKLabelNode!
    var countOfEnemy = 0
    var possibleEnemies = ["ball","hammer","tv"]
    var gameTimer: Timer?
    var timeInterval = 0.5
    var isGameOver = false
    var score = 0 {
        didSet{
            scoreLabel.text = "Score \(score)"
        }
    }
    override func didMove(to view: SKView) {
        startGame()
    }
    func startGame(){
        lastScoreLabel = SKLabelNode(text: "Last Score: ")
        lastScoreLabel.position = CGPoint(x: 514, y: 350)
        lastScoreLabel.fontSize = CGFloat(50)
        lastScoreLabel.isHidden = true
        addChild(lastScoreLabel)
        
        highestScoreLabel = SKLabelNode(text: "Highest Score: ")
        highestScoreLabel.position = CGPoint(x: 514, y: 250)
        lastScoreLabel.fontSize = CGFloat(50)
        highestScoreLabel.isHidden = true
        addChild(highestScoreLabel)
        
        
        restartLabel = SKLabelNode(text: "Restart Game")
        restartLabel.position = CGPoint(x: 518, y: 482)
        restartLabel.fontSize = CGFloat(100)
        restartLabel.name = "restartLabel"
        
        restartLabel.isUserInteractionEnabled = true
        restartLabel.isHidden = true
        addChild(restartLabel)
        
        backgroundColor = .black
        starfield = SKEmitterNode(fileNamed: "starfield")!
        starfield.position = CGPoint(x: 1024, y: 384)
        starfield.advanceSimulationTime(10)
        addChild(starfield)
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        score = 0
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        gameTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
    }
    @objc func createEnemy(){
        if !isGameOver{
            
            guard let enemy = possibleEnemies.randomElement() else{return}
            let sprite = SKSpriteNode(imageNamed: enemy)
            sprite.position = CGPoint(x: 1200, y: Int.random(in: 30...756))
            addChild(sprite)
            sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            sprite.physicsBody?.categoryBitMask = 1
            sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
            sprite.physicsBody?.angularVelocity = 5
            sprite.physicsBody?.linearDamping = 0
            sprite.physicsBody?.angularDamping = 0
            countOfEnemy += 1
            if countOfEnemy>=20{
                countOfEnemy = 0
                if timeInterval == 0.5{
                    timeInterval = 1
                }else{
                    timeInterval = 0.5
                }
                gameTimer?.invalidate()
                gameTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else{return}
        var location = touch.location(in: self)
        if location.y-player.position.y > 30  || player.position.y-location.y > 30 {
            return
        }
        if location.y < 100{
            location.y = 100
        }else if location.y > 668{
            location.y = 668
        }
        player.position = location
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesBegan(touches, with: event)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children{
            if node.position.x < -300 {
                node.removeFromParent()
                if isGameOver{
                    let defaults = UserDefaults.standard
                    let highestScore = defaults.integer(forKey: "highestScore")
                    defaults.set(score, forKey: "lastScore")
                    let lastScore = defaults.integer(forKey: "lastScore")
                    if highestScore < lastScore{
                        defaults.set(lastScore, forKey:"highestScore")
                    }
                    highestScoreLabel.text = String(highestScore)
                    lastScoreLabel.text = String(lastScore)
                    starfield.isPaused = true
                    restartLabel.isHidden = false
                    highestScoreLabel.isHidden = false
                    lastScoreLabel.isHidden = false
                    
                }
            }
        }
        if !isGameOver{
            score+=1
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
       
        let location = touch.location(in: self)
        let objects = nodes(at: location)
        
        if(objects.contains(restartLabel)){
            score = 0
            removeAllChildren()
            isGameOver = false
            startGame()
        }
    }
    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "explosion")
        explosion?.position = player.position
        addChild(explosion!)
        player.removeFromParent()
        isGameOver = true
    }
}
