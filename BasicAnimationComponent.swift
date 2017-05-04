//
//  BasicAnimationComponent.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


class BasicAnimationComponent: GKComponent{
    
    
    let animationsDict: [String: SKAction]
    
    var animationNode: SKSpriteNode?
    
    init(animationsDict: [String: SKAction]){
        self.animationsDict = animationsDict
        super.init()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didAddToEntity() {
        animationNode = entity?.component(ofType: RenderComponent.self)?.node
    }
    
    override func willRemoveFromEntity() {
        animationNode = nil
    }
    
    func runAnimation(withAnimationNameOf animationName: String, andWithAnimationKeyOf animationKey: String, onChildNodeWithName childNodeName: String, repeatForever: Bool = true){
        
        guard let node = animationNode else {
            print("Error: An animation node must be initialized in order to run an animation")
            return }
        
        
        guard let requestedAnimation = animationsDict[animationName] else {
            print("Errror: The requested animations could not be retrieved from the animations dictionary")
            return }
        
        let adjustedAnimation = repeatForever ? SKAction.repeatForever(requestedAnimation) : requestedAnimation
        
        let finalAnimation = SKAction.run(adjustedAnimation, onChildWithName: childNodeName)
        
        node.run(finalAnimation)
    }
    
    func runAnimation(withAnimationNameOf animationName: String, andWithAnimationKeyOf animationKey: String, repeatForever: Bool = true){
        
        guard let node = animationNode else {
            print("Error: An animation node must be initialized in order to run an animation")
            return }
        
        
        guard let requestedAnimation = animationsDict[animationName] else {
            print("Errror: The requested animations could not be retrieved from the animations dictionary")
            return }
        
        let finalAnimation = repeatForever ? SKAction.repeatForever(requestedAnimation) : requestedAnimation
        
        node.run(finalAnimation, withKey: animationKey)
    }
    
    func removeAnimation(withAnimationKeyOf animationKey: String){
        
        guard let node = animationNode else {
            print("Error: An animation node must be initialized in order to run an animation")
            return }
        
        if node.action(forKey: animationKey) != nil {
            node.removeAction(forKey: animationKey)

        }
        
    }
}
