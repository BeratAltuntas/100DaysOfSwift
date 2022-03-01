//
//  GameScene.swift
//  Project14
//
//  Created by BERAT ALTUNTAŞ on 1.03.2022.
//

import SpriteKit

class GameScene: SKScene {
    var gameScore: SKLabelNode!
    var slots = [WhackSlot]()
    var popupTime = 0.85
    var score = 0 {
        didSet{
            gameScore.text = "Score: \(score)"
        }
    }
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        for i in 0..<5{ CreateSlot(at: CGPoint(x: 100 + (i * 170), y: 410)) }
        for i in 0..<4{ CreateSlot(at: CGPoint(x: 180 + (i * 170), y: 320)) }
        for i in 0..<5{ CreateSlot(at: CGPoint(x: 100 + (i * 170), y: 230)) }
        for i in 0..<4{ CreateSlot(at: CGPoint(x: 180 + (i * 170), y: 140)) }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            [weak self] in
            self?.CreateEnemy()
        }
        
    }
      
    
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    func CreateSlot(at position: CGPoint){
        let slot = WhackSlot()
        slot.Configure(at: position)
        addChild(slot)
        slots.append(slot)
    }
    
    func CreateEnemy(){
        popupTime += 0.991
        slots.shuffle()
        slots[0].Show(hideTime: popupTime)
        if Int.random(in: 0...12) > 4{  slots[1].Show(hideTime: popupTime)  }
        if Int.random(in: 0...12) > 6{  slots[2].Show(hideTime: popupTime)  }
        if Int.random(in: 0...12) > 8{  slots[3].Show(hideTime: popupTime)  }
        if Int.random(in: 0...12) > 10{  slots[4].Show(hideTime: popupTime)  }
        if Int.random(in: 0...12) > 11{  slots[5].Show(hideTime: popupTime)  }
        
        let minDelay = popupTime / 2.0
        let maxDelay = popupTime * 2
        let delay = Double.random(in: minDelay...maxDelay)
        DispatchQueue.main.asyncAfter(deadline: .now()+delay){
            [weak self] in
            self?.CreateEnemy()
        }
        
    }
}
