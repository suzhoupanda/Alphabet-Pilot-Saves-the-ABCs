//
//  FieldEmittingComponent.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

/**  Adds a field node as a subnode to the render node; the field node is disabled by default, and can be enabled when the player enters the proximity of the field node, or at regular intervals
 
 **/

class FieldEmittingComponent: GKComponent{
    
    enum FieldType:String{
        case RadialField, TurbulenceField, ElectricField, VortexField, LinearGravityField
    }
    
    
    var fieldNode: SKFieldNode?
    
    var frameCount: TimeInterval = 0.00
    var fieldInterval: TimeInterval = 5.00
    
    convenience init(fieldInterval: TimeInterval, fieldType: FieldType, strength: Float, falloff: Float, smoothness: Float, minimumRadius: Float, isExclusive: Bool, region: SKRegion, linearGravityFieldVector: vector_float3?) {
        
        self.init()
        
            self.frameCount = 0.00
            self.fieldInterval = fieldInterval
        
            switch fieldType {
                case .RadialField:
                    fieldNode = SKFieldNode.radialGravityField()
                    break
                case .TurbulenceField:
                    fieldNode = SKFieldNode.turbulenceField(withSmoothness: 1.00, animationSpeed: 0.00)
                    break
                case .ElectricField:
                    fieldNode = SKFieldNode.electricField()
                    break
                case .VortexField:
                    fieldNode = SKFieldNode.vortexField()
                    break
                case .LinearGravityField:
                    let linearGravFieldVector = linearGravityFieldVector ?? vector_float3(0.0, 0.0, 0.0)
                    fieldNode = SKFieldNode.linearGravityField(withVector: linearGravFieldVector)
                    break
                default:
                    fieldNode = nil
                    break
        }
        
        
        if let fieldNode = fieldNode{
            fieldNode.name = fieldType.rawValue
            fieldNode.categoryBitMask = 0b1 << 0
            fieldNode.falloff = falloff
            fieldNode.minimumRadius = minimumRadius
            fieldNode.strength = strength
            fieldNode.smoothness = smoothness
            fieldNode.isExclusive = isExclusive
            fieldNode.region = region
            
            fieldNode.isEnabled = false
            
        }
        
        
    }
    override init() {
        super.init()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        frameCount += seconds
        
        if frameCount > fieldInterval{
            
            if let fieldNode = fieldNode{
                let currentFieldNodeState = fieldNode.isEnabled
                fieldNode.isEnabled = !currentFieldNodeState
            }
            
            frameCount = 0
        }
    }
    
    override func didAddToEntity() {
        
        guard let renderNode = entity?.component(ofType: RenderComponent.self)?.node else {
            print("Error (failed to add filed node): A field emtting component can only be added to an entity with a render node")
            return
        }
        
        if let fieldNode = fieldNode{
            renderNode.addChild(fieldNode)
        }
        
    }
    
    
    override func willRemoveFromEntity() {
        if var fieldNode = fieldNode{
            fieldNode.removeFromParent()

        }
    }
}
