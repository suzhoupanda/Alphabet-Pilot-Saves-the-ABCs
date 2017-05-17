//
//  RenderComponent.swift
//  AlphabetPilot
//
//  Created by Aleksander Makedonski on 4/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class RenderComponent: GKComponent{
    
    //MARK: Properties 
    
    var node = SKSpriteNode()
    
    /** AutoRemove and AutoReposition allow for sprite nodes backing up an entity to automatically reposition or remove themselves based on pre-defined criteria
 
 
     **/
    
    
    
    var autoRepositioningEnabled: Bool = false
    var autoRemoveEnabled: Bool = false
    
    var autoRemoveFrameCount: TimeInterval = 0.00
    var autoRemoveInterval: TimeInterval = 4.00
    
    var autoRepositionFrameCount: TimeInterval = 0.00
    var autoRepositionInterval: TimeInterval = 5.00
    
    var position: CGPoint = .zero
    var originalPosition: CGPoint = .zero
    
    override init() {
        super.init()
    }
    
    
    convenience init(spriteNode: SKSpriteNode) {
        self.init()
        self.node = spriteNode
        self.position = spriteNode.position
        self.originalPosition = spriteNode.position
    }
    
    convenience init(position: CGPoint, autoRemoveEnabled: Bool = false) {
        self.init()
        self.position = position
        self.originalPosition = position

        self.autoRemoveEnabled = autoRemoveEnabled
    }
    
    
    convenience init(position: CGPoint, autoRepositioningEnabled: Bool = false) {
        self.init()
        self.position = position
        self.originalPosition = position
        self.autoRepositioningEnabled = autoRepositioningEnabled

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: GKComponent Base-Class Methods 
    
    override func didAddToEntity() {
        node.entity = entity
        node.position = position
    }
    
    override func willRemoveFromEntity() {
        node.entity = nil 
    }
    
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        
        
        
        if autoRemoveEnabled{
            
            autoRemoveFrameCount += seconds
            
            if(autoRemoveFrameCount > autoRepositionInterval){
            
                node.run(SKAction.fadeOut(withDuration: 3.00), completion: {
                    self.node.removeFromParent()
                })
                
                autoRemoveFrameCount = 0
            }
        }
        
        if autoRepositioningEnabled {
            
            autoRepositionFrameCount += seconds
            
            if(autoRepositionFrameCount > autoRepositionInterval){
                
                
                    self.node.run(SKAction.fadeOut(withDuration: 3.00))
                    self.repositionNode()
                    
                
                    
                
                autoRepositionFrameCount = 0
            }
        
        
        }
        
        
       
        
    }
    
    func repositionNode(){
        //TODO: NOT YET IMPLEMENTED
        let xPos = 0.00
        let yPos = 0.00
        node.position = CGPoint(x: xPos, y: yPos)
        self.node.alpha = 1.00

    }
    
    
    func resetToOriginalPosition(){
        node.position = originalPosition
    }
    
    

}
