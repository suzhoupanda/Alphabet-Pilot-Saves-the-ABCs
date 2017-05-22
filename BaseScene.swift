//
//  GameScene.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class BaseScene: SKScene {
    
    
    var entityManager: EntityManager!
    
    var player: Player!
    var reloadData: ReloadData? = nil
    
   

    
     
    
    var worldNode: SKSpriteNode!
    var overlayNode: SKSpriteNode!
    var hudManager = HUDManager.sharedHUDManager
    
    var gameIsPaused: Bool = false
    
    var placeholderGraph: GKMeshGraph<GKGraphNode2D>?
    var obstacleGraph: GKObstacleGraph<GKGraphNode2D>?
    
    var skSceneFileName: String
    var sceneLetterTarget: String = String()
    
    var letterScene: LetterScene = .LetterA_Scene
    
    let screenRecorderHelper = ScreenRecorderHelper.sharedHelper

    var lastUpdateTime : TimeInterval = 0
    
    /**  The letter is attained when the player flies past the x-position of the letter.  Upon attaining the letter, the scene's state machine enter the LevelSceneSuccessState
 
    **/
    
    lazy var stateMachine : GKStateMachine = GKStateMachine(states: [
            LevelSceneFailState(levelScene: self),
            LevelSceneActiveState(levelScene: self),
            LevelSceneSuccessState(levelScene: self),
            LevelScenePauseState(levelScene: self)
        ])
    
    
    
    
    //MARK: ******************  Initializers
    
    required init(sksFileName: String, size: CGSize, reloadData: ReloadData?){
        self.skSceneFileName = sksFileName
        self.reloadData = reloadData
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
        addWorldNode(forSKView: view)
        
        /** Add the overlay node **/
        addOverlayNode(forSKView: view)

        /** Set up HUD display **/
        setupHUD()
        
        
        
        /** Set up the pause button **/
        setupPauseButton()
        
        
        /** Enttiy manager is added after the world node has been added to the scene **/
        entityManager = EntityManager(scene: self)
        
        /** Add player to the entity manager; retain a reference to the player in the scene itself for convenience; player is added prior to loading nodes from the SKScene file in order that its node can be used as a target node for certain enemies **/
        addPlayer()
        
        /** Add enemies, obstacles, and backgrounds to world from SKScene file. The player must be initialized before the smart enemies (i.e. those that use the player as a target agent) to be initialized from the scene file **/
        loadNodesFromSKSceneFile()
        
        
        /** Switch the state machine into the active state  **/
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
    
    
  
    
    
    //MARK: ********** GAME LOOP FUNCTIONS
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        stateMachine.update(deltaTime: currentTime)

        if stateMachine.currentState is LevelScenePauseState {
            print("Game is paused: cannot run updates on entity manager or component systems")
            return }
        
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        
        
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
        // NotificationCenter.default.addObserver(self, selector: #selector(BaseScene.reportPlayerRangePosition(notification:)), name: Notification.Name.PlayerEnteredPredefinedRange, object: nil)
        
       
    }
    
    func saveCurrentGameSession(){
        
        print("Saving game data...")
        
        guard let playerPosition = player.component(ofType: RenderComponent.self)?.node.position else {
            
            print("Error: Unable to load player render component while saving game")
            return
        }
        
        guard let playerVelocity = player.component(ofType: PhysicsComponent.self)?.physicsBody.velocity else {
            
            print("Error: Unable to load player physics component while saving game")
            return
        }
        
        
        guard let playerHealthComponent = player.component(ofType: HealthComponent.self) else {
            
            print("Error: Unable to load player health component while saving game")
            return
        }
        
        
        guard let playerCollectibleComponent = player.component(ofType: CollectibleStorageComponent.self) else {
            
            print("Error: Unable to load player collectible component while saving game")
            return
        }
        
        guard let playerStateMachine = player.component(ofType: IntelligenceComponent.self) else {
            print("Error: Unable to load player state machine while performing game save operation")
            return
        }
    
        let playerXPos = Double(playerPosition.x)
        let playerYPos = Double(playerPosition.y)
        
        let playerXVelocity = Double(playerVelocity.dx)
        let playerYVelocity = Double(playerVelocity.dy)
        
        let healthVal = Int16(playerHealthComponent.currentHealth)
        let planeColor = player.planeColor.rawValue
        let goldCoinCount = Int16(playerCollectibleComponent.goldCoinCount)
        let silverCoinCount = Int16(playerCollectibleComponent.silverCoinCount)
        let bronzeCoinCount = Int16(playerCollectibleComponent.bronzeCoinCount)
        let playerDamageStatus = playerStateMachine.stateMachine?.currentState is PlayerDamagedState
        let playerSceneName = letterScene.rawValue
        let playerLetterTarget = sceneLetterTarget
        let currentDate = Date()
        
        let userInfo: [String: Any] = [
            "playerXPosition" : playerXPos,
            "playerYPosition" : playerYPos,
            "playerXVelocity" : playerXVelocity,
            "playerYVelocity" : playerYVelocity,
            "playerHealth" : healthVal,
            "playerPlaneColor" : planeColor,
            "playerGoldCoinCount": goldCoinCount,
            "playerSilverCointCount" : silverCoinCount,
            "playerBronzeCoinCount" : bronzeCoinCount,
            "playerDamageStatus" : playerDamageStatus,
            "playerSceneName" : playerSceneName,
            "playerLetterTarget" : playerLetterTarget,
            "playerDateSaved" : currentDate
        ]
        
        NotificationCenter.default.post(name: Notification.Name.UserRequestedGameSaveNotification, object: BaseScene.self, userInfo: userInfo)
      
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
