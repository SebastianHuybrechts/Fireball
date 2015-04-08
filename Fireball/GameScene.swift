//
//  GameScene.swift
//  Fireball
//
//  Created by Sebastian Huybrechts on 15/12/14.
//  Copyright (c) 2014 ___SEBASTIANHUYBRECHTS___. All rights reserved.
//

import Spritekit
import AVFoundation

class GameScene: SKScene {

    var background = SKSpriteNode(imageNamed: "Background1")
    
    let fireball = SKSpriteNode(imageNamed: "Fireball")
    let tapToStart = SKSpriteNode(imageNamed: "Tap To Start")
    
    let dragonRight = SKSpriteNode(imageNamed: "Dragon Right")
    let dragonLeft = SKSpriteNode(imageNamed: "Dragon Left")
    
    var ground = SKSpriteNode()
    
    var chinese = SKSpriteNode()

    let noAdsButton = SKSpriteNode(imageNamed: "No Ads")
    let noAds1Button = SKSpriteNode(imageNamed: "No Ads1")
    
    let rankingButton = SKSpriteNode(imageNamed: "Ranking")
    let ranking1Button = SKSpriteNode(imageNamed: "Ranking1")
    
    let musicOffButton = SKSpriteNode(imageNamed: "Music OFF")
    let musicOff1Button = SKSpriteNode(imageNamed: "Music OFF1")
    let musicOnButton = SKSpriteNode(imageNamed: "Music ON")
    let musicOn1Button = SKSpriteNode(imageNamed: "Music ON1")

    
    let soundOffButton = SKSpriteNode(imageNamed: "Sound OFF")
    let soundOff1Button = SKSpriteNode(imageNamed: "Sound OFF1")
    let soundOnButton = SKSpriteNode(imageNamed: "Sound ON")
    let soundOn1Button = SKSpriteNode(imageNamed: "Sound ON1")
    
    var audioPlayer = AVAudioPlayer()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // Music
        
        var startScreen = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Startscreen", ofType: "mp3")!)
        
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: startScreen, error: nil)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        audioPlayer.numberOfLoops = -1
        
        // PhysicsWorld
        self.physicsWorld.gravity = CGVectorMake(0.0, -7.0)
        
        //Background
        self.backgroundColor = UIColor.whiteColor()
        
        self.background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
        background.zPosition = -5
        self.addChild(self.background)
        
        self.fireball.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 40)
        self.addChild(self.fireball)
        
        self.tapToStart.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 90)
        tapToStart.setScale(0.6)
        self.addChild(self.tapToStart)
        
        self.dragonRight.position = CGPointMake(20, CGRectGetMidY(self.frame) + 40)
        dragonRight.setScale(0.65)
        self.addChild(self.dragonRight)
        
        self.dragonLeft.position = CGPointMake(CGRectGetMaxX(self.frame) - 20, CGRectGetMidY(self.frame) + 40)
        dragonLeft.setScale(0.65)
        self.addChild(self.dragonLeft)
        
        // Ground
        var groundTexture = SKTexture(imageNamed: "Ground")
        
        ground = SKSpriteNode(texture: groundTexture)
        ground.setScale(0.95)
        ground.zPosition = 2
        ground.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinX(self.frame))
        
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, groundTexture.size().height * 0.95))
        
        ground.physicsBody!.dynamic = false
        self.addChild(ground)
        
        //Chinese
        var chineseTexture = SKTexture(imageNamed: "Chinese")
        chineseTexture.filteringMode = SKTextureFilteringMode.Nearest
        
        chinese = SKSpriteNode(texture: chineseTexture)
        chinese.setScale(0.6)
        chinese.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) + groundTexture.size().height)
        
        chinese.physicsBody = SKPhysicsBody(rectangleOfSize: chinese.size)
        chinese.physicsBody!.dynamic = true
        chinese.physicsBody!.allowsRotation = false
        chinese.zPosition = 3
        
        self.addChild(chinese)
                
        // Menu
        // No Ads
        self.noAdsButton.position = CGPointMake(CGRectGetMinX(self.frame) + 50, CGRectGetMidY(self.frame) - 70)
        noAdsButton.setScale(0.15)
        self.addChild(self.noAdsButton)
        
        self.noAds1Button.position = CGPointMake(CGRectGetMinX(self.frame) + 50, CGRectGetMidY(self.frame) - 70)
        noAds1Button.setScale(0.15)
        noAds1Button.zPosition = -1
        self.addChild(self.noAds1Button)

        // Ranking
        self.rankingButton.position = CGPointMake(CGRectGetMinX(self.frame) + 70, CGRectGetMidY(self.frame) - 130)
        rankingButton.setScale(0.15)
        self.addChild(self.rankingButton)
        
        self.ranking1Button.position = CGPointMake(CGRectGetMinX(self.frame) + 70, CGRectGetMidY(self.frame) - 130)
        ranking1Button.setScale(0.15)
        ranking1Button.zPosition = -1
        self.addChild(self.ranking1Button)
        
        // Music
        self.musicOnButton.position = CGPointMake(CGRectGetMaxX(self.frame) - 70, CGRectGetMidY(self.frame) - 130)
        soundOnButton.setScale(0.15)
        musicOnButton.setScale(0.15)
        self.addChild(self.musicOnButton)
        
        self.musicOn1Button.position = CGPointMake(CGRectGetMaxX(self.frame) - 70, CGRectGetMidY(self.frame) - 130)
        musicOn1Button.zPosition = -1
        musicOn1Button.setScale(0.15)
        self.addChild(self.musicOn1Button)
        
        self.musicOff1Button.position = CGPointMake(CGRectGetMaxX(self.frame) - 70, CGRectGetMidY(self.frame) - 130)
        musicOff1Button.zPosition = -0.5
        musicOff1Button.setScale(0.15)
        self.addChild(self.musicOff1Button)
        
        self.musicOffButton.position = CGPointMake(CGRectGetMaxX(self.frame) - 70, CGRectGetMidY(self.frame) - 130)
        musicOffButton.zPosition = -1
        musicOffButton.setScale(0.15)
        self.addChild(self.musicOffButton)
        
        musicOnButton.hidden = false
        musicOn1Button.hidden = true
        musicOffButton.hidden = true
        musicOff1Button.hidden = true
        
        
        // Sound
        self.soundOnButton.position = CGPointMake(CGRectGetMaxX(self.frame) - 50, CGRectGetMidY(self.frame) - 70)
        soundOnButton.setScale(0.15)
        self.addChild(self.soundOnButton)
        
        self.soundOn1Button.position = CGPointMake(CGRectGetMaxX(self.frame) - 50, CGRectGetMidY(self.frame) - 70)
        soundOn1Button.zPosition = -1
        soundOn1Button.setScale(0.15)
        self.addChild(self.soundOn1Button)
        
        self.soundOff1Button.position = CGPointMake(CGRectGetMaxX(self.frame) - 50, CGRectGetMidY(self.frame) - 70)
        soundOff1Button.zPosition = -0.5
        soundOff1Button.setScale(0.15)
        self.addChild(self.soundOff1Button)
        
        self.soundOffButton.position = CGPointMake(CGRectGetMaxX(self.frame) - 50, CGRectGetMidY(self.frame) - 70)
        soundOffButton.zPosition = -1
        soundOffButton.setScale(0.15)
        self.addChild(self.soundOffButton)
        
        soundOnButton.hidden = false
        soundOn1Button.hidden = true
        soundOff1Button.hidden = true
        soundOffButton.hidden = true

        jumpChinese()
    }
    
    func jumpChinese(){
        let action = SKAction.moveBy(CGVector(dx: 0, dy: 3000), duration: 10)
        let repeatForever = SKAction.repeatActionForever(action)
        chinese.runAction(repeatForever)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)

            if self.nodeAtPoint(location) == self.soundOnButton || self.nodeAtPoint(location) == self.soundOffButton {
                
                if soundOffButton.hidden == true {
                    soundOnButton.hidden = true
                    soundOn1Button.hidden = false
                    soundOnButton.hidden = true
                    soundOffButton.hidden = true
                }
                else if soundOnButton.hidden == true {
                    soundOnButton.hidden = true
                    soundOn1Button.hidden = true
                    soundOff1Button.hidden = false
                    soundOffButton.hidden = true
                }
            }
            
            if self.nodeAtPoint(location) == self.musicOnButton || self.nodeAtPoint(location) == self.musicOffButton {
                
                if musicOffButton.hidden == true {
                    musicOnButton.hidden = true
                    musicOn1Button.hidden = false
                    musicOnButton.hidden = true
                    musicOffButton.hidden = true
                }
                else if musicOnButton.hidden == true {
                    musicOnButton.hidden = true
                    musicOn1Button.hidden = true
                    musicOff1Button.hidden = false
                    musicOffButton.hidden = true                }
            }
            
            if self.nodeAtPoint(location) == self.noAdsButton {
                noAdsButton.hidden = true
                noAds1Button.hidden = false
            }
            
            if self.nodeAtPoint(location) == self.rankingButton {
                rankingButton.hidden = true
                ranking1Button.hidden = false
            }

        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            if self.nodeAtPoint(location) == self.background {
                var scene = PlayScene(size: self.size)
                let skView = self.view as SKView!
                let reveal = SKTransition.fadeWithColor(UIColor.whiteColor(), duration: 1)
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .ResizeFill
                scene.size = skView.bounds.size
                self.view?.presentScene(scene, transition: reveal)
            }
            
            if self.nodeAtPoint(location) == self.soundOnButton || self.nodeAtPoint(location) == self.soundOffButton {
                
                if soundOn1Button.hidden == false {
                    soundOnButton.hidden = true
                    soundOn1Button.hidden == false
                    soundOff1Button.hidden = true
                    soundOffButton.hidden = false
                    audioPlayer.volume = 0
                } else if soundOff1Button.hidden == false {
                    soundOnButton.hidden = false
                    soundOn1Button.hidden == true
                    soundOff1Button.hidden = true
                    soundOffButton.hidden = true
                    audioPlayer.volume = 1
                }
            }
            
            if self.nodeAtPoint(location) == self.musicOnButton || self.nodeAtPoint(location) == self.musicOffButton {
                
                if musicOn1Button.hidden == false {
                    musicOnButton.hidden = true
                    musicOn1Button.hidden == false
                    musicOff1Button.hidden = true
                    musicOffButton.hidden = false
                } else if musicOff1Button.hidden == false {
                    musicOnButton.hidden = false
                    musicOn1Button.hidden == true
                    musicOff1Button.hidden = true
                    musicOffButton.hidden = true
                }
            }

            
            if self.nodeAtPoint(location) == self.noAdsButton {
                noAdsButton.hidden = false
                noAds1Button.hidden = true
            }
            
            if self.nodeAtPoint(location) == self.rankingButton {
                rankingButton.hidden = false
                ranking1Button.hidden = true
            }
    }
}
}