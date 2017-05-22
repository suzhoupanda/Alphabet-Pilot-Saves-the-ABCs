//
//  EntityManager.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import GameplayKit
import SpriteKit


class EntityManager{
    
    var entities = Set<GKEntity>()
    var toRemove = Set<GKEntity>()
    
    
    lazy var componentSystems: [GKComponentSystem] = {
        
        let renderComponent = GKComponentSystem(componentClass: RenderComponent.self)
        
        let graphNodeComponent = GKComponentSystem(componentClass: GraphNodeComponent.self)
        
        let fieldEmittingComponent = GKComponentSystem(componentClass: FieldEmittingComponent.self)
        
        let collectibleCoinComponent = GKComponentSystem(componentClass: CollectibleStorageComponent.self)
        
        //Physics Components
        
        let physicsComponent = GKComponentSystem(componentClass: PhysicsComponent.self)
        
        let rockSpawningComponent = GKComponentSystem(componentClass: RockSpawningComponent.self)
     
        let randomImpulseComponent = GKComponentSystem(componentClass: RandomImpulseComponent.self)
        
        let orientationComponent = GKComponentSystem(componentClass: OrientationComponent.self)
        
        let velocityComponent = GKComponentSystem(componentClass: VelocityComponent.self)
        
        let inputComponent = GKComponentSystem(componentClass: LandscapeMotionResponderComponentY.self)
        
        let targetDetectionComponent = GKComponentSystem(componentClass: TargetDetectionComponent.self)
        
        let bulletFiringComponent = GKComponentSystem(componentClass: BulletFiringComponent.self)
        
        let intelligenceComponent = GKComponentSystem(componentClass: IntelligenceComponent.self)
        
        return [renderComponent, graphNodeComponent, collectibleCoinComponent, physicsComponent, randomImpulseComponent, orientationComponent, inputComponent, velocityComponent, targetDetectionComponent, rockSpawningComponent, bulletFiringComponent, fieldEmittingComponent, intelligenceComponent]
        
    }()
    
    let scene: BaseScene
    
    init(scene: BaseScene){
        self.scene = scene
    }
    
    
    func update(_ deltaTime: CFTimeInterval){
        
        if scene.stateMachine.currentState is LevelScenePauseState {
            print("Game is paused: cannot run updates on the entity manager or component systems")
            return
        }
        
        for componentSystem in componentSystems{
            componentSystem.update(deltaTime: deltaTime)
        }
        
        
        for currentRemove in toRemove{
            for componentSystem in componentSystems{
                componentSystem.removeComponent(foundIn: currentRemove)
            }
        }
        
        toRemove.removeAll()
    }
    
    
    func addToEntitySet(_ entity: GKEntity){
        entities.insert(entity)
        
        for componentSystem in componentSystems{
            componentSystem.addComponent(foundIn: entity)
        }
    }
    
    
    func addToWorld(_ entity: GKEntity){
        entities.insert(entity)
        
        if let spriteNode = entity.component(ofType: RenderComponent.self)?.node{
            spriteNode.move(toParent: scene.worldNode)
        }
        
        for componentSystem in componentSystems{
            componentSystem.addComponent(foundIn: entity)
        }
    }
    
    
    func addToScene(_ entity: GKEntity){
        entities.insert(entity)
        
        if let spriteNode = entity.component(ofType: RenderComponent.self)?.node{
            spriteNode.move(toParent: scene)
        }
        
        for componentSystem in componentSystems{
            componentSystem.addComponent(foundIn: entity)
        }
        
    }
    
    
    func remove(_ entity: GKEntity){
        if let spriteNode = entity.component(ofType: RenderComponent.self)?.node{
            spriteNode.removeFromParent()
        }
        
        entities.remove(entity)
        toRemove.insert(entity)
    }
    
    func getPlayerEntities() -> [Player]{
        return self.entities.flatMap{entity in
            
            if let entity = entity as? Player{
                return entity
            }
            
            return nil
        }
    }
    
    
        
}
    
    
    
    
