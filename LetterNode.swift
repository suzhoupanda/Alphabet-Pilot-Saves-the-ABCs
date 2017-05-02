//
//  LetterNode.swift
//  AlphabetPilot
//
//  Created by Aleksander Makedonski on 4/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit


class LetterNode: SKSpriteNode{
    
    enum LetterCategory: String{
        case letterA, letterB, letterC, letterD, letterE, letterF, letterG, letterH
        case letterI, letterJ, letterK, letterL, letterM, letterN, letterO, letterP
        case letterQ, letterR, letterS, letterT, letterU, letterV, letterW, letterX
        case letterY, letterZ
        
        //MARK: ******** INITIALIZERS
        init(character: Character){
            
            switch character {
            case "A","a":
                self = .letterA
            case "B","b":
                self = .letterB
            case "C","c":
                self = .letterC
            case "D","d":
                self = .letterD
            case "E","e":
                self = .letterE
            case "F","f":
                self = .letterF
            case "G","g":
                self = .letterG
            case "H","h":
                self = .letterH
            case "I","i":
                self = .letterI
            case "J","j":
                self = .letterJ
            case "K","k":
                self = .letterK
            case "L","l":
                self = .letterL
            case "M","m":
                self = .letterM
            case "N","n":
                self = .letterN
            case "O","o":
                self = .letterO
            case "P","p":
                self = .letterP
            case "Q","q":
                self = .letterQ
            case "R","r":
                self = .letterR
            case "S","s":
                self = .letterS
            case "T","t":
                self = .letterT
            case "U","u":
                self = .letterU
            case "V","v":
                self = .letterV
            case "W","w":
                self = .letterW
            case "X","x":
                self = .letterX
            case "Y","y":
                self = .letterY
            case "Z","z":
                self = .letterZ
            default:
                self = .letterA
            }
        }
        
        var texture: SKTexture{
            get{
                return SKTexture(image: UIImage(named: self.rawValue)!)
            }
        }
        
        var letter: Character?{
            get{
                
                guard let letterCharacter = self.rawValue.characters.last else {
                    print("Could not compute letterCharacter for this LetterCategory enum case")
                    return nil
                    
                }
                
                return letterCharacter
            }
        }
        
        var stringLetter: String?{
            get{
                
                guard let letter = self.letter else {
                    print("Could not compute stringLetter for this LetterCategory enum case")
                    return nil
                }
                return String(letter)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(letter: LetterCategory, position: CGPoint, scalingFactor: CGFloat?) {
        var texture = letter.texture
        var textureSize = texture.size()
        
        self.init(texture: texture, color: .clear, size: textureSize)
        
        //Set position and anchorpoint
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = position
        
        //Configure node name
        self.name = letter.rawValue
        
        //Configure node physics properties
        self.physicsBody = SKPhysicsBody(texture: texture, size: textureSize)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = CollisionConfiguration.Letter.categoryMask
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionConfiguration.Letter.contactMask
        
        //Configure node scaling
        if let scalingFactor = scalingFactor{
            self.xScale *= scalingFactor
            self.yScale *= scalingFactor
        }
        
    }
    
}
