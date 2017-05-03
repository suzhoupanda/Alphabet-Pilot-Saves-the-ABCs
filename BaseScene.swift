//
//  GameScene.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import SpriteKit
import GameplayKit

class BaseScene: SKScene {
    
    
    var entityManager: EntityManager!
    
    var player: Player!
    var worldNode: SKSpriteNode!
    
    var placeholderGraph: GKMeshGraph<GKGraphNode2D>?
    var obstacleGraph: GKObstacleGraph<GKGraphNode2D>?
    
    var skSceneFileName: String
    
    private var lastUpdateTime : TimeInterval = 0
    
    /**  The letter is attained when the player flies past the x-position of the letter.  Upon attaining the letter, the scene's state machine enter the LevelSceneSuccessState
 
    **/
    
    lazy var stateMachine : GKStateMachine = GKStateMachine(states: [
            LevelSceneFailState(levelScene: self),
            LevelSceneActiveState(levelScene: self),
            LevelSceneSuccessState(levelScene: self),
            LevelScenePauseState(levelScene: self)
        ])
    
    
    
    
    //MARK: ******************  Initializers
    
    init(sksFileName: String, size: CGSize){
        self.skSceneFileName = sksFileName
        super.init(size: size)
        
        registerNotifications()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
     
    }
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.physicsWorld.contactDelegate = self
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        /** Add the world node **/
        worldNode = SKSpriteNode()
        worldNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        worldNode.position = .zero
        worldNode.scale(to: view.bounds.size)
        addChild(worldNode)
        
        /** Enttiy manager is added after the world node has been added to the scene **/
        entityManager = EntityManager(scene: self)
        
        /** Add player to the entity manager; retain a reference to the player in the scene itself for convenience; player is added prior to loading nodes from the SKScene file in order that its node can be used as a target node for certain enemies **/
        player = Player()
        entityManager.addToWorld(player)
        
        
        /** Add enemies, obstacles, and backgrounds to world from SKScene file. The player must be initialized before the smart enemies (i.e. those that use the player as a target agent) to be initialized from the scene file **/
        loadNodesFromSKSceneFile()
        
        
        /** Switch the state machine into the active state
 
        **/
        stateMachine.enter(LevelSceneActiveState.self)
    
        
    }
    
    
    func reportPlayerRangePosition(notification: Notification){
        let userInfo = notification.userInfo
        
        guard let minBoundary = userInfo?["minBoundary"] as? Int else {
            print("Error: no minimum boundary available for predefined range")
            return
        }
        
        guard let maxBoundary = userInfo?["maxBoundary"] as? Int else {
            print("Error: no maximumb boundary available for predefined range")
            return
        }
        
        print("The player entered a new position range....")
        print("The minimum boundary is: \(minBoundary)")
        print("The maximum boundary is: \(maxBoundary)")
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
      
    }
    
    func touchMoved(toPoint pos : CGPoint) {
      
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: worldNode)
        
        /** When the user touch is to the right of the player, velocity is increased; when it is to the left, velocity is decreased
 
        **/
        if let playerNode = player.component(ofType: RenderComponent.self)?.node{
            
            let velocityUpdateNotification: Notification.Name = touchLocation.x > playerNode.position.x ? Notification.Name.DidIncreasePlayerVelocityNotification :Notification.Name.DidDecreasePlayerVelocityNotification
                
            NotificationCenter.default.post(Notification(name: velocityUpdateNotification, object: nil, userInfo: nil))
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    //MARK: ********** GAME LOOP FUNCTIONS
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        
        stateMachine.update(deltaTime: currentTime)
        
        entityManager.update(dt)
      
        self.lastUpdateTime = currentTime
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        
        guard let playerNode = player.component(ofType: RenderComponent.self)?.node else { return }
        centerOnNode(node: playerNode)
    }
    
    
    //MARK: ******** CONVENIENCE METHODS
    
    func centerOnNode(node: SKNode){
        
        guard let world = self.worldNode else { return }
        
        let nodePositionInScene = self.convert(node.position, from: world)
        
        world.position = CGPoint(x: world.position.x - nodePositionInScene.x, y: world.position.y - nodePositionInScene.y)
        
        
    }
    
    func saveSpriteInformation(rootNode: SKNode){
        
        for node in rootNode.children{
            
            node.userData = NSMutableDictionary()
            let positionValue = NSValue(cgPoint: node.position)
            node.userData?.setValue(positionValue, forKey: "position")
            
            saveSpriteInformation(rootNode: node)
        }
    }
    
   
    func registerNotifications(){
         NotificationCenter.default.addObserver(self, selector: #selector(BaseScene.reportPlayerRangePosition(notification:)), name: Notification.Name.PlayerEnteredPredefinedRange, object: nil)
        
       
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
