//
//  Letter.swift
//  AlphabetPilot
//
//  Created by Aleksander Makedonski on 4/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class Letter: GKEntity{
    
    
    override init() {
        super.init()
    }
    
    convenience init(letterCategory: LetterNode.LetterCategory, position: CGPoint = .zero, letterMass: CGFloat = 1.00) {
        self.init()

       
        
        addRenderComponent(letterCategory: letterCategory, position: position)
        
        addPhysicsComponent(letterCategory: letterCategory, letterMass: letterMass)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addRenderComponent(letterCategory: LetterNode.LetterCategory,position: CGPoint, scalingFactor: CGFloat = 0.60){
        
        /** TODO:   Consider a convenience method for random start position, For the falling letters level:
        let startXPos = RandomGenerator.getRandomXPos(adjustmentFactor: 0.95)
        let startYPos = Int(ScreenSizeConstants.HalfScreenHeight) + 100
        let startPos = CGPoint(x: startXPos, y: startYPos)
        **/
        
        let letterNode = LetterNode(letter: letterCategory, position: position, scalingFactor: 1.00)
        
        let renderComponent = RenderComponent(spriteNode: letterNode)
        
        addComponent(renderComponent)
    }
    
    func addPhysicsComponent(letterCategory: LetterNode.LetterCategory, letterMass: CGFloat){
        
        guard let letterNode = component(ofType: RenderComponent.self)?.node else {
                print("AN entity must have a render component in order for a physics component to be added")
                return
        }
        
        let letterTexture = letterCategory.texture
        let letterTextureSize  = letterTexture.size()
        
        let physicsBody = letterNode.physicsBody ?? SKPhysicsBody(texture: letterTexture, size: letterTextureSize)
        physicsBody.mass = letterMass
        physicsBody.affectedByGravity = false
        physicsBody.isDynamic = false
        physicsBody.allowsRotation = false
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Letter)
        addComponent(physicsComponent)
        
        
    }
    
    /**  Contact handler for the letter entity:
     
    func addContactHandlerComponent(letterCategory: LetterNode.LetterCategory){
        let contactHandlerComponent = ContactHandlerComponent(categoryBeginContactHandler:  {
            
            otherCategoryBitmask in
            
            let renderComponent = self.component(ofType: RenderComponent.self)
            
            switch(otherCategoryBitmask){
            case CollisionConfiguration.Barrier.categoryMask:
                //print("Letter \(letterCategory.stringLetter) hit the barrier")
                
                /**
                 spriteNode.run(SKAction.fadeAlpha(to: 0.00, duration: 2.0), completion: {
                 spriteNode.physicsBody?.affectedByGravity = false
                 spriteNode.position = CGPoint(x: RandomGenerator.getRandomXPos(adjustmentFactor: 0.90), y: Int(ScreenSizeConstants.ScreenHeight+100))
                 
                 
                 })
                 
                 spriteNode.run(SKAction.wait(forDuration: 10), completion: {
                 spriteNode.physicsBody?.affectedByGravity = true
                 })
                 **/
                break
            case CollisionConfiguration.Player.categoryMask:
                print("Letter \(letterCategory.stringLetter) hit the player")
                
                let nc = NotificationCenter.default
                let userInfo = ["letter": letterCategory.letter]
                nc.post(name: Notification.Name.PlayerDidContactLetterNotification, object: nil, userInfo: userInfo)
                break
            default:
                print("No contact logic implemented")
            }
        } , nodeBeginContactHandler: nil, categoryEndContactHandler: nil, nodeEndContactHandler: nil)
        
        addComponent(contactHandlerComponent)
    }
    
     **/

    //MARK: The agent used when pathfinding to a target tile at a certain ground location
    
   // let agent: GKAgent2D
    
    //MARK: Helper Method: Post a notificaiton
}


//TODO:     Consider overloading the = operator as well as other the copy() method to further    customize the manner in which letters are copied

extension Letter{
    
    func replicate() -> Letter{
        let duplicateLetter = Letter()
        
        for component in self.components{
            duplicateLetter.addComponent(component)
        }
        
        return duplicateLetter
    }
}
