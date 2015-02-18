//
//  PlayScene.swift
//  Fireball
//
//  Created by Sebastian Huybrechts on 25/12/14.
//  Copyright (c) 2014 ___SEBASTIANHUYBRECHTS___. All rights reserved.
//

import SpriteKit

class PlayScene: SKScene {
    
    var chinese = SKSpriteNode()
    var background = SKSpriteNode(imageNamed: "Background")
    var originalBackgroundPositionY = CGFloat(0)
    var maxBackgroundY = CGFloat(0)
    var backgroundSpeed = 5
    
    var dragonRightTexture = SKTexture(imageNamed: "Dragon Right")
    var dragonLeftTexture = SKTexture(imageNamed: "Dragon Left")
    var dragonsMoveAndRemove = SKAction()
    
    var ground = SKSpriteNode()
    
    var score = 0
    let scoreText = SKLabelNode(fontNamed: "Wonton by Da Font Mafia")
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.scoreText.text = "0"
        self.scoreText.fontSize = 42
        self.scoreText.fontColor = UIColor.darkGrayColor()
        self.scoreText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)/4*3.3)
        
        // Background
        self.background.anchorPoint = CGPointMake(0.5, 0)
        self.background.position = CGPointMake(
            CGRectGetMidX(self.frame),
            CGRectGetMinY(self.frame))
        background.zPosition = -1

        self.originalBackgroundPositionY = self.background.position.y
        self.maxBackgroundY = self.background.size.height - self.frame.size.height
        self.maxBackgroundY *= -1

        // Dragon
        // Movement of dragons
        let distanceToMove = CGFloat(self.frame.size.height + 3.0 * dragonRightTexture.size().height * 2)
        let moveDragons = SKAction.moveToY(-distanceToMove, duration: NSTimeInterval(0.01 * distanceToMove))
        let removeDragons = SKAction.removeFromParent()
        
        dragonsMoveAndRemove = SKAction.sequence([moveDragons, removeDragons])
        
        // Spawn Pipes
        let spawn = SKAction.runBlock({() in self.spawnDragons()})
        let delay = SKAction.waitForDuration(NSTimeInterval(2.5))
        let spawnThenDelay = SKAction.sequence([spawn,delay])
        let spawnThenDelayForever = SKAction.repeatActionForever(spawnThenDelay)
        self.runAction(spawnThenDelayForever)
      
        // Phisics
        self.physicsWorld.gravity = CGVectorMake(0.0, -7.0)
        
        // Ground
        var groundTexture = SKTexture(imageNamed: "Ground")
        
        ground = SKSpriteNode(texture: groundTexture)
        ground.setScale(0.95)
        ground.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinX(self.frame))
        
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, groundTexture.size().height * 0.76))
        
        ground.physicsBody!.dynamic = false
        
        //Chinese
        var chineseTexture = SKTexture(imageNamed: "Chinese")
        chineseTexture.filteringMode = SKTextureFilteringMode.Nearest
        
        chinese = SKSpriteNode(texture: chineseTexture)
        chinese.setScale(0.6)
        chinese.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) + groundTexture.size().height * 0.76)
        
        chinese.physicsBody = SKPhysicsBody(rectangleOfSize: chinese.size)
        chinese.physicsBody!.dynamic = true
        chinese.physicsBody!.allowsRotation = false
        
        self.addChild(self.background)
        self.addChild(self.chinese)
        self.addChild(self.ground)
        self.addChild(self.scoreText)
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        if self.background.position.y <= maxBackgroundY {
            self.background.position.y = self.originalBackgroundPositionY
        }
        
        background.position.y -= CGFloat(self.backgroundSpeed)
    }
    
    func spawnDragons() {
        let dragonPair = SKNode()
        dragonPair.position = CGPointMake(0, self.frame.size.height)
        
        let dragonRight = SKSpriteNode(texture: dragonRightTexture)
        dragonRight.setScale(0.5)
        dragonRight.position = CGPointMake(CGRectGetMinX(self.frame) + 17, CGRectGetMaxY(self.frame) * 0.75)
        dragonPair.addChild(dragonRight)
        
        let dragonLeft = SKSpriteNode(texture: dragonLeftTexture)
        dragonLeft.setScale(0.5)
        dragonLeft.position = CGPointMake(CGRectGetMaxX(self.frame) - 17, CGRectGetMidY(self.frame))
        dragonPair.addChild(dragonLeft)
        
        dragonPair.runAction(dragonsMoveAndRemove)
        self.addChild(dragonPair)

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            self.nodeAtPoint(location)
            
            chinese.physicsBody?.velocity = CGVectorMake(0, 0)
            chinese.physicsBody?.applyImpulse(CGVectorMake(0, 175))

        }
    }
}