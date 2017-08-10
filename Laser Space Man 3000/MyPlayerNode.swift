//
//  MySKSpriteNode.swift
//  Laser Space Man 3000
//
//  Created by Josh Zignego on 8/3/17.
//  Copyright © 2017 Josh Zignego. All rights reserved.
//

import Foundation
import SpriteKit

class MyPlayerNode: SKSpriteNode {
    var movingUp : Bool = false
    var movingDown : Bool = false
    var movingRight : Bool = false
    var movingLeft : Bool = false
    var doRunAnimation : Bool = false
    var doKickingAnimation : Bool = false
    var doJumpAnimation : Bool = false
    
    init() {
        let texture = SKTexture(imageNamed: "Running FLANNEL-1")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
    }
    
    func initializePlayer(scene: GameScene) {
        self.position = CGPoint(x: size.width * 0.1, y: size.height * 1 / 7 + CGFloat(scene.yScaler)*size.height/2)
        self.zPosition = 0
        let width: Double = Double(size.width) * scene.xScaler
        let height: Double = Double(size.height) * scene.yScaler
        self.scale(to: CGSize(width: width, height: height))
        scene.addChild(self)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = true
        //self.physicsBody?.linearDamping = 1
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        //self.physicsBody?.friction = 1
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.ShootEnemy | PhysicsCategory.RamEnemy
        self.physicsBody?.collisionBitMask = PhysicsCategory.Platform | PhysicsCategory.Barrier
    }
    
    func beginRunAnimation() {
        if doKickingAnimation {
            stopKickingAnimation()
        }
        if doJumpAnimation {
            doJumpAnimation = false
        }
        if doRunAnimation {
            return
        }
        doRunAnimation = true
        let textureAtlas = SKTextureAtlas(named: "Badger")
        let frames = ["Running FLANNEL-1", "Running FLANNEL-2", "Running FLANNEL-3", "Running FLANNEL-4"].map { textureAtlas.textureNamed($0) }
        let animate = SKAction.animate(with: frames, timePerFrame: 0.2)
        let forever = SKAction.repeatForever(animate)
        self.run(forever, withKey: "runningAnimation")
    }
    
    func stopRunAnimation() {
        if doRunAnimation {
            self.removeAction(forKey: "runningAnimation")
        }
        doRunAnimation = false
    }
    
    func beginKickAnimation() {
        if doRunAnimation {
            stopRunAnimation()
        }
        if doJumpAnimation {
            doJumpAnimation = false
        }
        //print("Kick Animation")
        let textureAtlas = SKTextureAtlas(named: "Badger")
        let frames = ["Kicking FLANNEL-1", "Kicking FLANNEL-3", "Kicking FLANNEL-3"].map { textureAtlas.textureNamed($0) }
        let animate = SKAction.animate(with: frames, timePerFrame: 0.2)
        self.run(animate)
        self.texture = SKTexture(imageNamed: "Kicking FLANNEL-3")
    }
    
    func stopKickingAnimation() {
        doKickingAnimation = false
    }
    
    func beginReverseKickAnimation() {
        if doRunAnimation {
            stopRunAnimation()
        }
        if doJumpAnimation {
            doJumpAnimation = false
        }
        //print("Kick Animation")
        doKickingAnimation = true
        let textureAtlas = SKTextureAtlas(named: "Badger")
        let frames = ["Reverse Kicking FLANNEL-1", "Reverse Kicking FLANNEL-3", "Reverse Kicking FLANNEL-3"].map { textureAtlas.textureNamed($0) }
        let animate = SKAction.animate(with: frames, timePerFrame: 0.2)
        self.run(animate)
        self.texture = SKTexture(imageNamed: "Reverse Kicking FLANNEL-3")
    }
    
    func beginJumpAnimation() {
        if doKickingAnimation {
            stopKickingAnimation()
        }
        if doRunAnimation {
            stopRunAnimation()
        }
        self.texture = SKTexture(imageNamed: "Jumping FLANNEL-1")
        doJumpAnimation = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMoving(direction: String, value: Bool) {
        if direction == "up" {
            movingUp = value
        }
        else if direction == "down" {
            movingDown = value
        }
        else if direction == "right" {
            movingRight = value
        }
        else if direction == "left" {
            movingLeft = value
        }
    }
    
    func isMoving(direction: String) -> Bool {
        if direction == "up" {
            return movingUp
        }
        else if direction == "down" {
            return movingDown
        }
        else if direction == "right" {
            return movingRight
        }
        else if direction == "left" {
            return movingLeft
        }
        return false
    }
}
