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
    
    var dragonRight = SKSpriteNode(imageNamed: "Dragon Right")
    var dragonRight2 = SKSpriteNode(imageNamed: "Dragon Right")
    var dragonLeft = SKSpriteNode(imageNamed: "Dragon Left")
    
    var fireRight = SKSpriteNode(imageNamed: "Fire Right")
    var fireLeft = SKSpriteNode(imageNamed: "Fire Left")

    let fireLeftMoveAction =  SKAction()
    let fireRightMoveAction = SKAction()
    
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
        
        // Phisics
        self.physicsWorld.gravity = CGVectorMake(0.0, -7.0)
        
        // Dragons
        dragonRight.setScale(0.5)
        dragonRight.zPosition = 3
        dragonRight.position = CGPointMake(CGRectGetMinX(self.frame) + 17, CGRectGetMaxY(self.frame) * 2/3)
        addChild(dragonRight)
        
        dragonLeft.setScale(0.5)
        dragonLeft.zPosition = 3
        dragonLeft.position = CGPointMake(CGRectGetMaxX(self.frame) - 17, CGRectGetMidY(self.frame))
        addChild(dragonLeft)
        
        dragonRight2.setScale(0.5)
        dragonRight2.zPosition = 3
        dragonRight2.position = CGPointMake(CGRectGetMinX(self.frame) + 17, CGRectGetMidY(self.frame) * 2/3)
        addChild(dragonRight2)
        
        // Fire
        let fireDistanceToMoveLeft = fireLeft.size.width
        let fireLeftMoveAction = SKAction.moveByX(-fireDistanceToMoveLeft * 2, y: 0, duration: 0.5)
        
        let fireDistanceToMoveRight = fireRight.size.width
        let fireRightMoveAction = SKAction.moveByX(fireDistanceToMoveRight * 2, y: 0, duration: 0.5)
        
        fireLeft.zPosition = -1
        fireLeft.position = CGPointMake(CGRectGetMaxX(self.frame), dragonLeft.position.y)
        fireLeft.hidden = true
        fireLeft.runAction(fireLeftMoveAction)
        addChild(fireLeft)
        
        fireRight.zPosition = -1
        fireRight.position = CGPointMake(CGRectGetMinX(self.frame), dragonRight.position.y)
        fireRight.hidden = true
        fireRight.runAction(fireRightMoveAction)
        addChild(fireRight)
        
        if randomFire() < 15 {
            fireLeft.runAction(fireLeftMoveAction)
            fireLeft.hidden = false
        }
        if randomFire() > 85 {
            fireRight.runAction(fireRightMoveAction)
            fireRight.hidden = false
        }

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
        
        // Bottom
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody = borderBody
                
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
            ground.position.y -= CGFloat(self.backgroundSpeed)

            
//            if self.chinese.position.y >= CGRectGetMaxY(self.frame) - self.chinese.size.height / 2 {
//                self.chinese.position.y = CGRectGetMaxY(self.frame) - self.chinese.size.height / 2
//            }
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