//
//  RandomGenerator.swift
//  AlphabetPilot
//
//  Created by Aleksander Makedonski on 4/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import GameplayKit


class RandomGenerator{
    
    enum ScreenEdge{
        case Top, Left, Right, Bottom
    }
    
    static func getRandomScreenPoint() -> CGPoint{
        
        let minHorizontal = -Int(ScreenSizeConstants.HalfScreenWidth)
        let maxHorizontal = Int(ScreenSizeConstants.HalfScreenWidth)
        
        let minVertical = -Int(ScreenSizeConstants.HalfScreenHeight)
        let maxVertical = Int(ScreenSizeConstants.HalfScreenHeight)
        
        let rDistHorizontal = GKRandomDistribution(lowestValue: minHorizontal, highestValue: maxHorizontal)
        let rDistVertical = GKRandomDistribution(lowestValue: minVertical, highestValue: maxHorizontal)
        
        
        let randomXPos = rDistHorizontal.nextInt()
        let randomYPos = rDistVertical.nextInt()
        
        return CGPoint(x: randomXPos, y: randomYPos)
        
    }
    
    static func getRandomXPos(adjustmentFactor: CGFloat = 1.00) -> Int{
        
        let randomSource = GKLinearCongruentialRandomSource()
        
        let minValue = -Int(ScreenSizeConstants.HalfScreenWidth*adjustmentFactor)
        let maxValue = Int(ScreenSizeConstants.HalfScreenWidth*adjustmentFactor)
        
        let randomDist = GKShuffledDistribution(randomSource: randomSource, lowestValue: minValue, highestValue: maxValue)
        
        return randomDist.nextInt()
    }
    
    static func getRandomYPos() -> Int{
        let randomSource = GKLinearCongruentialRandomSource()
        
        let minValue = -Int(ScreenSizeConstants.HalfScreenHeight)
        let maxValue = Int(ScreenSizeConstants.HalfScreenHeight)
        
        let randomDist = GKShuffledDistribution(randomSource: randomSource, lowestValue: minValue, highestValue: maxValue)
        
        return randomDist.nextInt()
    }
    
    static func getRandomSpriteWidth(minWidth: Int, maxWidth: Int) -> Int{
        let randomSource = GKLinearCongruentialRandomSource()
        let randomDist = GKShuffledDistribution(randomSource: randomSource, lowestValue: minWidth, highestValue: maxWidth)
        
        return randomDist.nextInt()
    }
    
    static func getRandomSpriteHeight(minHeight: Int, maxHeight: Int) -> Int{
        let randomSource = GKLinearCongruentialRandomSource()
        let randomDist = GKShuffledDistribution(randomSource: randomSource, lowestValue: minHeight, highestValue: maxHeight)
        
        return randomDist.nextInt()
    }
    
    static func getRandomSpriteSize(minWidth: Int, maxWidth: Int, minHeight: Int, maxHeight: Int) -> CGSize{
        
        let randomWidth = getRandomSpriteWidth(minWidth: minWidth, maxWidth: maxWidth)
        let randomHeight = getRandomSpriteHeight(minHeight: minHeight, maxHeight: maxHeight)
        
        return CGSize(width: randomWidth, height: randomHeight)
    }
    
    static func getRandomBoxSpriteSize(minSide: Int, maxSide: Int) -> CGSize{
        let sideLength = getRandomSpriteWidth(minWidth: minSide, maxWidth: maxSide)
        
        return CGSize(width: sideLength, height: sideLength)
    }
    
    static func getRandomGaussianScalingFactor(meanScalingFactor: Float, scalingFactorDeviation: Float) -> Float{
        
        let randomSource = GKLinearCongruentialRandomSource()
        let rDist = GKGaussianDistribution(randomSource: randomSource, mean: meanScalingFactor, deviation: scalingFactorDeviation)
        
        return rDist.nextUniform()
    }
    
    static func getRandomEdgePointFor(screenEdge: ScreenEdge) -> CGPoint{
        
        let randomSource = GKLinearCongruentialRandomSource()
        
        let minHorizontal = -Int(ScreenSizeConstants.HalfScreenWidth)
        let maxHorizontal = Int(ScreenSizeConstants.HalfScreenWidth)
        
        let minVertical = -Int(ScreenSizeConstants.HalfScreenHeight)
        let maxVertical = Int(ScreenSizeConstants.HalfScreenHeight)
        
        let horizontalDist = GKRandomDistribution(randomSource: randomSource, lowestValue: minHorizontal, highestValue: maxHorizontal)
        
        let verticalDist = GKRandomDistribution(randomSource: randomSource, lowestValue: minVertical, highestValue: maxVertical)
        
        
        
        var randomEdgePoint: CGPoint
        
        let xPos = horizontalDist.nextInt()
        let yPos = verticalDist.nextInt()
        
        switch(screenEdge){
        case .Bottom:
            randomEdgePoint = CGPoint(x: xPos, y: -Int(ScreenSizeConstants.HalfScreenHeight))
            break
        case .Left:
            randomEdgePoint = CGPoint(x: -Int(ScreenSizeConstants.HalfScreenWidth), y: yPos)
            break
        case .Right:
            randomEdgePoint = CGPoint(x: Int(ScreenSizeConstants.HalfScreenWidth), y: yPos)
            break
        case .Top:
            randomEdgePoint = CGPoint(x: xPos, y: Int(ScreenSizeConstants.HalfScreenHeight))
            break
        }
        
        return randomEdgePoint
        
    }
    
    static func getEdgePointAt(edgePosition: Int, forScreenEdge screenEdge: ScreenEdge) -> CGPoint{
        
        
        var edgePoint: CGPoint
        
        switch(screenEdge){
        case .Bottom:
            edgePoint = CGPoint(x: edgePosition, y: -Int(ScreenSizeConstants.HalfScreenHeight))
            break
        case .Left:
            edgePoint = CGPoint(x: -Int(ScreenSizeConstants.HalfScreenWidth), y: edgePosition)
            break
        case .Right:
            edgePoint = CGPoint(x: Int(ScreenSizeConstants.HalfScreenWidth), y: edgePosition)
            break
        case .Top:
            edgePoint = CGPoint(x: edgePosition, y: Int(ScreenSizeConstants.HalfScreenHeight))
            break
        }
        
        return edgePoint
        
    }
    
}
