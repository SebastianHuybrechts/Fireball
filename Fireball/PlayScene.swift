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
    
    let dragonRight1 = SKSpriteNode(imageNamed: "Dragon Right")
    
    var ground = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor.whiteColor()
        
        // Background
        self.background.position = CGPointMake(
            CGRectGetMidX(self.frame),
            CGRectGetMinY(self.frame))
        
        background.zPosition = -1

        self.originalBackgroundPositionY = self.background.position.y
        self.maxBackgroundY = self.background.size.height - self.frame.size.height
        self.maxBackgroundY *= -1

        //Dragon
        
        self.dragonRight1.position = CGPointMake(CGRectGetMinX(self.frame) + 17, 200)
        dragonRight1.setScale(0.50)
        
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
        
        chinese.physicsBody = SKPhysicsBody(circleOfRadius: chinese.size.height / 2.0)
        chinese.physicsBody!.dynamic = true
        chinese.physicsBody!.allowsRotation = false
        

        
        self.addChild(background)
        self.addChild(chinese)
        self.addChild(ground)
        self.addChild(self.dragonRight1)
        
    }
    
    
    override func update(currentTime: NSTimeInterval) {
        if self.background.position.y <= maxBackgroundY {
        self.background.position.y = self.originalBackgroundPositionY
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