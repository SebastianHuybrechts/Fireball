//
//  GameScene.swift
//  Fireball
//
//  Created by Sebastian Huybrechts on 15/12/14.
//  Copyright (c) 2014 ___SEBASTIANHUYBRECHTS___. All rights reserved.
//

import Spritekit

class GameScene: SKScene {

    var background = SKSpriteNode(imageNamed: "Background1")
    
    let fireball = SKSpriteNode(imageNamed: "Fireball")
    let tapToStart = SKSpriteNode(imageNamed: "Tap To Start")
    
    let dragonRight = SKSpriteNode(imageNamed: "Dragon Right")
    let dragonLeft = SKSpriteNode(imageNamed: "Dragon Left")
    
    var chinese = SKSpriteNode()

    let musicOffButton = SKSpriteNode(imageNamed: "Music OFF")
    let musicOnButton = SKSpriteNode(imageNamed: "Music ON")
    let soundOffButton = SKSpriteNode(imageNamed: "Sound OFF")
    let soundOnButton = SKSpriteNode(imageNamed: "Sound ON")
    let rankingButton = SKSpriteNode(imageNamed: "Ranking")
    let noAdsButton = SKSpriteNode(imageNamed: "No Ads")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = UIColor.whiteColor()
        
        self.background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
        self.addChild(self.background)
        
        self.fireball.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 40)
        self.addChild(self.fireball)
        
        self.tapToStart.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 90)
        tapToStart.setScale(0.6)
        self.addChild(self.tapToStart)
        
        self.dragonRight.position = CGPointMake(20, CGRectGetMidY(self.frame))
        dragonRight.setScale(0.75)
        self.addChild(self.dragonRight)
        
        self.dragonLeft.position = CGPointMake(CGRectGetMaxX(self.frame) - 20, CGRectGetMidY(self.frame))
        dragonLeft.setScale(0.75)
        self.addChild(self.dragonLeft)
        
        
        //Chinese
        var chineseTexture = SKTexture(imageNamed: "Chinese")
        chineseTexture.filteringMode = SKTextureFilteringMode.Nearest
        
        chinese = SKSpriteNode(texture: chineseTexture)
        chinese.setScale(0.6)
        chinese.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.5)
        
        
        chinese.physicsBody = SKPhysicsBody(circleOfRadius: chinese.size.height / 2.0)
        chinese.physicsBody!.dynamic = true
        chinese.physicsBody!.allowsRotation = false
        
        self.addChild(chinese)
        
        // Ground
        var groundTexture = SKTexture(imageNamed: "Ground")
        var sprite = SKSpriteNode(texture: groundTexture)
        sprite.setScale(0.35)
        sprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinX(self.frame))
        
        var ground = SKNode()
        
        ground.position = CGPointMake(0, groundTexture.size().height)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, groundTexture.size().height * 2.0))
        
        ground.physicsBody?.dynamic = false
        self.addChild(ground)
                
        // Menu
        
        self.noAdsButton.position = CGPointMake(80, 200)
        self.addChild(self.noAdsButton)

        self.rankingButton.position = CGPointMake(130, 200)
        self.addChild(self.rankingButton)
        
        self.musicOnButton.position = CGPointMake(180, 200)
        self.addChild(self.musicOnButton)
        
        self.soundOnButton.position = CGPointMake(230, 200)
        self.addChild(self.soundOnButton)
        
        //self.musicOffButton.position = CGPointMake()
        //self.addChild(self.musicOffButton)
        
        //self.soundOffButton.position = CGPointMake()
        //self.addChild(self.soundOffButton)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)

            self.nodeAtPoint(location)
            var scene = PlayScene(size: self.size)
            let skView = self.view as SKView!
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .ResizeFill
            scene.size = skView.bounds.size
            skView.presentScene(scene)
        }
    }
    
       override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
            for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            
        }
        
}
}