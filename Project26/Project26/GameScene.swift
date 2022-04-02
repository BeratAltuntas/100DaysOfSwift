    //
    //  GameScene.swift
    //  Project26
    //
    //  Created by BERAT ALTUNTAŞ on 30.03.2022.
    //
import CoreMotion
import SpriteKit

enum CollisionTypes:UInt32{
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case finish = 16
    case portal = 32
}
class GameScene: SKScene,SKPhysicsContactDelegate {
    var player: SKSpriteNode!
    var lastTouchPosition: CGPoint!
    
    var changePortal = true
    var portals = [SKSpriteNode]()
    var scoreLabel: SKLabelNode!
    var creatingPlayerDefaultPosition = CGPoint(x: 96, y: 672)
    var remainingLives = 3
    var level = 1
    var isGameOver = false
    var score = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var motionManager: CMMotionManager?
    
    override func didMove(to view: SKView) {
        startGame()
    }
    func startGame(){
        createBackground()
        createScoreLabel()
        let levelTextureString = loadLevelTexture()
        createObjects(with: levelTextureString)
        createPlayer(where: creatingPlayerDefaultPosition)
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
    }
    func createBackground(){
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
    }
    func createScoreLabel(){
        scoreLabel = SKLabelNode(fontNamed: "chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
    }
    func loadLevelTexture()->String{
        guard let levelUrl = Bundle.main.url(forResource: "level" + String(level), withExtension: "txt") else {
            fatalError("Could not find level1.txt in the app bundle.")}
        guard let levelString = try? String(contentsOf: levelUrl) else {
            fatalError("Could not load level1.txt from the app bundle.")}
        return levelString
    }
    
    func createObjects(with levelString: String){
        let lines = levelString.components(separatedBy: "\n")
        for (row,line) in lines.reversed().enumerated(){
            for (coloumn,letter) in line.enumerated(){
                let position = CGPoint(x:(64 * coloumn) + 32,y: (64 * row) + 32)
                
                if letter == "x"{
                        // load wall
                    
                    let node = SKSpriteNode(imageNamed: "block")
                    node.position = position
                    
                    node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                    node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
                    node.physicsBody?.isDynamic = false
                    
                    addChild(node
                    )
                }else if letter == "v"{
                        // load vortex
                    
                    let node = SKSpriteNode(imageNamed: "vortex")
                    node.name = "vortex"
                    node.position = position
                    node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    
                    node.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    addChild(node)
                }else if letter == "s"{
                        // load star
                    
                    let node = SKSpriteNode(imageNamed: "star")
                    node.name = "star"
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    node.position = position
                    addChild(node)
                }else if letter == "f"{
                        // load finish point
                    
                    let node = SKSpriteNode(imageNamed: "finish")
                    node.name = "finish"
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    
                    node.physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    node.position = position
                    addChild(node)
                }else if letter == "t"{
                        // load teleport point
                    let node = SKSpriteNode(imageNamed: "portal")
                    node.name = "portal"
                    node.position = position
                    node.size = CGSize(width: 65, height: 65)
                    
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.categoryBitMask = CollisionTypes.portal.rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    
                    
                    addChild(node)
                    portals.append(node)
                }else if letter == " "{
                        // this is a empty space do nothing
                }else{
                    fatalError("Unknown level letter: \(letter).")
                }
            }
        }
    }
    func createPlayer(where position: CGPoint){
        player = SKSpriteNode(imageNamed: "player")
        player.position = position
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.linearDamping = 0.5
        player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
        player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.portal.rawValue | CollisionTypes.vortex.rawValue | CollisionTypes.finish.rawValue
        player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
        player.zPosition = 2
        addChild(player)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPosition = nil
    }
    override func update(_ currentTime: TimeInterval) {
        guard isGameOver == false else{return}
        
#if targetEnvironment(simulator)
        if let lastTouchPosition = lastTouchPosition{
            let diff = CGPoint(x: lastTouchPosition.x - player.position.x, y: lastTouchPosition.y - player.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
#else
        if let accelerometerData = motionManager?.accelerometerData{
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
#endif
    }
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else{return}
        guard let nodeB = contact.bodyB.node else{return}
        if nodeA == player{
            playerCollided(with: nodeB)
        }else if nodeB == player{
            playerCollided(with: nodeA)
        }
    }
    
    func playerCollided(with node: SKNode){
        if node.name == "vortex"{
            player.physicsBody?.isDynamic = false
            isGameOver = true
            score -= 1
            remainingLives -= 1
            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(to: 0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            
            let sequence = SKAction.sequence([move,scale,remove])
            
            player.run(sequence){
                [weak self] in
                self?.createPlayer(where: self!.creatingPlayerDefaultPosition)
                self?.isGameOver = false
            }
            
            if remainingLives <= 0{
                isGameOver = true
                physicsWorld.speed = 0
                
            }
        }else if node.name == "star"{
            node.removeFromParent()
            score += 1
        }else if node.name == "finish"{
            node.removeFromParent()
            removeAllActions()
            removeAllChildren()
            level += 1
            remainingLives = 3
            startGame()
        }else if node.name == "portal"{
            print("portal")
            if changePortal{
                changePortal = false
                player.removeFromParent()
                player.speed = 0
                createPlayer(where: CGPoint(x: portals[0].position.x, y: portals[0].position.y + 55))
                
            }else{
                changePortal = true
                player.removeFromParent()
                player.speed = 0
                createPlayer(where: CGPoint(x: portals[1].position.x, y: portals[1].position.y + 55))
                
            }
            
        }
    }
}
