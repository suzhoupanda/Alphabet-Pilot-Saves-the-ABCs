//
//  Constants.swift
//  AlphabetPilot
//
//  Created by Aleksander Makedonski on 4/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit

class ScreenSizeConstants{
    static let ScreenSize = UIScreen.main.bounds.size
    static let ScreenWidth = UIScreen.main.bounds.size.width
    static let ScreenHeight = UIScreen.main.bounds.size.height
    static let HalfScreenHeight = UIScreen.main.bounds.size.height/2.00
    static let HalfScreenWidth = UIScreen.main.bounds.size.width/2.00
}

class ScreenPoints{
    static let TopLeftCorner = CGPoint(x: -Int(ScreenSizeConstants.HalfScreenWidth), y: Int(ScreenSizeConstants.HalfScreenHeight))
    static let TopRightCorner = CGPoint(x: Int(ScreenSizeConstants.HalfScreenWidth), y: Int(ScreenSizeConstants.HalfScreenHeight))
    static let BottomLeftCorner = CGPoint(x: -Int(ScreenSizeConstants.HalfScreenWidth), y: -Int(ScreenSizeConstants.HalfScreenHeight))
    static let BottomRightCorner = CGPoint(x: Int(ScreenSizeConstants.HalfScreenWidth), y: -Int(ScreenSizeConstants.HalfScreenHeight))
}

class FontNames{
    static let Noteworthy = "Noteworthy"
    static let NoteworthyBold = "Noteworthy-Bold"
    static let NoteworthLight = "Noteworthy-Light"
}

