//
//  UIColor+Extension.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/11/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit


extension UIColor{
    
    enum ColorScheme1{
        case BrightWarm(red: Int, green: Int, blue: Int)
        case DarkWarm(red: Int, green: Int, blue: Int)
        case BrightCool(red: Int, green: Int, blue: Int)
        case DarkCool(red: Int, green: Int, blue: Int)
        case Neutral(red: Int, green: Int, blue: Int)
    }
    
    enum CustomColor{
        case StopSignRed
        case SharkFinWhite
        case BluishGrey
        case GrassyGreen
        case DirtBrown
    }
    
    static func GetCustomColor(customColor: CustomColor) -> UIColor{
        switch(customColor){
            case .StopSignRed:
                return UIColor(colorLiteralRed: 218.0/255.0, green: 40.0/255.0, blue: 46.0/255.0, alpha: 1.00)
            case .SharkFinWhite:
                return UIColor(colorLiteralRed: 226.0/255.0, green: 237.0/255.0, blue: 242.0/255.0, alpha: 1.00)
            case .BluishGrey:
                return UIColor(colorLiteralRed: 173.0/255.0, green: 206.0/255.0, blue: 218.0/255.0, alpha: 1.00)
            case .GrassyGreen:
                return UIColor(colorLiteralRed: 152.0/255.0, green: 188.0/255.0, blue: 70.0/255.0, alpha: 1.00)
            case .DirtBrown:
                return UIColor(colorLiteralRed: 138.0/255.0, green: 104.0/255.0, blue: 72.0/255.0, alpha: 1.00)
        }
    }
}
