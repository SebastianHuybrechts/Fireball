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
    var fireRightTexture = SKTexture(imageNamed: "Fire Right")
    var fireLeftTexture = SKTexture(imageNamed: "Fire Left")
    var fireRightMove = SKAction()
    var fireLeftMove = SKAction()
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
        background.zPosition = -10

        self.originalBackgroundPositionY = self.background.position.y
        self.maxBackgroundY = self.background.size.height - self.frame.size.height
        self.maxBackgroundY *= -1

        // Dragon
        // Movement of dragons
        let distanceToMove = CGFloat(self.frame.size.height + 3.0 * dragonRightTexture.size().height * 2)
        let moveDragons = SKAction.moveToY(-distanceToMove, duration: NSTimeInterval(0.01 * distanceToMove))
        let removeDragons = SKAction.removeFromParent()
        
        dragonsMoveAndRemove = SKAction.sequence([moveDragons, removeDragons])
        
        // Spawn Dragons
        let spawn = SKAction.runBlock({() in self.spawnDragons()})
        let delay = SKAction.waitForDuration(NSTimeInterval(2.5))
        let spawnThenDelay = SKAction.sequence([spawn,delay])
        let spawnThenDelayForever = SKAction.repeatActionForever(spawnThenDelay)
        self.runAction(spawnThenDelayForever)
        
        // Move fire
//        let fireDistanceToMove = fireRightTexture.size().width
//        let fireRightMove = SKAction.moveBy(CGVector(dx: fireDistanceToMove + 150, dy: 0), duration: 2)
//        let fireLeftMove = SKAction.moveBy(CGVector(dx: -fireDistanceToMove - 150, dy: 0), duration: 2)
        
        // Phisics
        self.physicsWorld.gravity = CGVectorMake(0.0, -7.0)
        
        // Ground
        var groundTexture = SKTexture(imageNamed: "Ground")
        
        ground = SKSpriteNode(texture: groundTexture)
        ground.setScale(0.95)
        ground.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinX(self.frame))
        ground.zPosition = 7
        
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, groundTexture.size().height * 0.76))
        
        ground.physicsBody!.dynamic = false
        
        //Chinese
        var chineseTexture = SKTexture(imageNamed: "Chinese")
        chineseTexture.filteringMode = SKTextureFilteringMode.Nearest
        
        chinese = SKSpriteNode(texture: chineseTexture)
        chinese.setScale(0.6)
        chinese.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) + groundTexture.size().height * 0.76)
        chinese.zPosition = 10
        
        chinese.physicsBody = SKPhysicsBody(rectangleOfSize: chinese.size)
        chinese.physicsBody!.dynamic = true
        chinese.physicsBody!.allowsRotation = false
        
        self.addChild(self.background)
        self.addChild(self.chinese)
        self.addChild(self.ground)
        self.addChild(self.scoreText)
        
    }
    
    func randomFire() -> UInt32 {
        var fireRange = UInt32(0)..<UInt32(100)
        return fireRange.startIndex + arc4random_uniform(fireRange.endIndex - fireRange.startIndex + 1)
    }
    
    override func update(currentTime: NSTimeInterval) {
        if self.background.position.y <= maxBackgroundY {
            self.background.position.y = self.originalBackgroundPositionY
        }
        background.position.y -= CGFloat(self.backgroundSpeed)
        
        if self.chinese.position.y >= CGRectGetMaxY(self.frame) - self.chinese.size.height / 2 {
            self.chinese.position.y = CGRectGetMaxY(self.frame) - self.chinese.size.height / 2
        }
    }
    
    func spawnDragons() {
        let dragonPair = SKNode()
        dragonPair.position = CGPointMake(0, self.frame.size.height)
        
        let dragonRight = SKSpriteNode(texture: dragonRightTexture)
        dragonRight.setScale(0.5)
        dragonRight.zPosition = 3
        dragonRight.position = CGPointMake(CGRectGetMinX(self.frame) + 17, CGRectGetMaxY(self.frame) * 0.75)
        dragonPair.addChild(dragonRight)
        
        let fireRight =  SKSpriteNode(texture: fireRightTexture)
        fireRight.zPosition = -1
        fireRight.position = CGPointMake(CGRectGetMinX(self.frame) + 160, dragonRight.position.y)
        fireRight.hidden = true
        dragonPair.addChild(fireRight)
        
        let dragonLeft = SKSpriteNode(texture: dragonLeftTexture)
        dragonLeft.setScale(0.5)
        dragonLeft.zPosition = 3
        dragonLeft.position = CGPointMake(CGRectGetMaxX(self.frame) - 17, CGRectGetMidY(self.frame))
        dragonPair.addChild(dragonLeft)
        
        let fireLeft =  SKSpriteNode(texture: fireLeftTexture)
        fireLeft.zPosition = -1
        fireLeft.hidden = true
        fireLeft.position = CGPointMake(CGRectGetMaxX(self.frame) - 160, dragonLeft.position.y)
        dragonPair.addChild(fireLeft)
        
        dragonPair.runAction(dragonsMoveAndRemove)
        self.addChild(dragonPair)
        
        if randomFire() < 30 {
            //runAction(fireLeftMove)
            fireLeft.hidden = false
        }
        
        if randomFire() > 70 {
            //runAction(fireRightMove)
            fireRight.hidden = false
        }

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