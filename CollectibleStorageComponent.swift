//
//  CollectibleStorageComponent.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/6/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


class CollectibleStorageComponent: GKComponent{
    
    var totalCoinValue = 0
    var lifeThreshold = 20
    var processedNodeNames = [String]()
    
    convenience init(lifeThreshold: Int) {
        self.init()
        
        self.lifeThreshold = lifeThreshold
    }
    
    override init() {
        super.init()
        
        registerNotifications()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        print("The total coin value is \(totalCoinValue)")
        
        guard let healthComponent = entity?.component(ofType: HealthComponent.self) else {
            print("Error: Entity must have health component in order to perform update on CollectibleStorageComponent")
            return
        }
        
        if totalCoinValue > lifeThreshold{
            healthComponent.currentHealth += 1
            totalCoinValue = 0
        }
        
        
    }
    
    func increaseCoinValue(notification: Notification){
        
        guard let userInfoDict = notification.userInfo, let coinType = userInfoDict["coinType"] as? String, let coinNodeName = userInfoDict["coinNodeName"] as? String else {
            print("Error: failed to retrieve coin type from notification's user info dictionary")
            return
        }
        
        /** If the contacted coin is contacted for the first time, its node name is added to the processed node names array and the notification is further processed.  If the contacted coin continues to initiate contact events and broadcast notifications, its node name will already be in the array and the selector will exit.
        
        **/
        
        if !processedNodeNames.contains(coinNodeName) {
            processedNodeNames.append(coinNodeName)
        } else { return }
        
        let capitalizedCoinType = coinType.capitalized
        
        guard let contactedCoinType = Coin.CoinType(rawValue: capitalizedCoinType) else {
            print("Error: failed to initialize a coin type for the contacted coin type")
            return
        }
        
        totalCoinValue += contactedCoinType.coinValue
        
    }
    
    func registerNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(CollectibleStorageComponent.increaseCoinValue(notification:)), name: Notification.Name.PlayerContactedCoinNotification, object: nil)
      
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
