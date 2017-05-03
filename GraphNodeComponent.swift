//
//  GraphNodeComponent.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import SpriteKit
import GameplayKit


class GraphNodeComponent: GKComponent{
    
    var graphNode: GKGraphNode2D = GKGraphNode2D()
    
    init(cgPosition: CGPoint){
        graphNode.position = cgPosition.getVectorFloat2()
        super.init()
    }
    
    init(vfPosition: vector_float2){
        graphNode.position = vfPosition
        super.init()
        
    }
    
    init(graphNode: GKGraphNode2D){
        self.graphNode = graphNode
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        guard let renderNode = entity?.component(ofType: RenderComponent.self)?.node else {
            print("The render node must be available in order to update the position of the node on the graph")
            return
        }
        
        graphNode.position = renderNode.position.getVectorFloat2()
    }
}
