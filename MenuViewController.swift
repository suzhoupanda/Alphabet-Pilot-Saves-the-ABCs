//
//  MenuViewController.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/13/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


class MenuViewController: UIViewController{
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    typealias CurrentSizeClassConfiguration = (UIUserInterfaceSizeClass, UIUserInterfaceSizeClass)
    
    
    var mainStackView: UIStackView!
    
    var mainTitleView: UIView!
    var buttonStackView: UIStackView!
    
   
    
    var mainTitleViewConstraints: [NSLayoutConstraint]{
        
        get{
            
            var constraintsArray = [NSLayoutConstraint]()
            
            let CurrentSizeClassConfiguration = (traitCollection.verticalSizeClass,traitCollection.horizontalSizeClass)
            
            switch(CurrentSizeClassConfiguration){
                case (.regular, .compact),(.regular,.regular):
                    configureMainTitleConstraints(forVerticalSizeClass: .regular, forMainTitleConstraintsIn: &constraintsArray)
                    break
                case (.compact, .regular),(.compact,.compact):
                    configureMainTitleConstraints(forVerticalSizeClass: .compact, forMainTitleConstraintsIn: &constraintsArray)
                    break
                default:
                    break
            }
            
            return constraintsArray
            
        }
    }
    
    var buttonStackViewConstraints: [NSLayoutConstraint]{
        
        get{
            var constraintsArray = [NSLayoutConstraint]()
            
            let CurrentSizeClassConfiguration = (traitCollection.verticalSizeClass,traitCollection.horizontalSizeClass)
    
            switch(CurrentSizeClassConfiguration){
                case (.regular, .compact),(.regular,.regular):
                    configureButtonStackViewConstraints(forVerticalSizeClass: .regular, forMainTitleConstraintsIn: &constraintsArray)
                    break
                case (.compact, .regular),(.compact,.compact):
                    configureButtonStackViewConstraints(forVerticalSizeClass: .compact, forMainTitleConstraintsIn: &constraintsArray)
                    break
                default:
                    break
            }
            
            return constraintsArray
        }
    }

    
    
   
    
   
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    
        let CurrentSizeClassConfiguration = (traitCollection.verticalSizeClass, traitCollection.horizontalSizeClass)
        
        
        mainTitleView = UIView()
        buttonStackView = UIStackView()
        
        mainTitleView.backgroundColor = UIColor.red
        buttonStackView.backgroundColor = UIColor.blue
        
        mainStackView = UIStackView(arrangedSubviews: [
            mainTitleView,buttonStackView
            ])
        
        //The alignment of the main stack view is based on the current trait collection of the ViewController's main view 
        
        switch(CurrentSizeClassConfiguration){
            case (.regular,.compact),(.regular,.regular):
                mainStackView.axis = .vertical
                break
            case (.compact,.regular),(.compact,.compact):
                mainStackView.axis = .horizontal
                break
            default:
                break
        
        }
        
        
        
        //The main stack view is pinned to the outer edges of the main view 
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
                mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
                mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor),
                mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor),
                mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
    
        buttonStackView.axis = .vertical
        
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .equalCentering
        
        let buttonStartGame = UIButton(type: .system)
        buttonStartGame.titleEdgeInsets = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
        buttonStartGame.titleLabel?.text = "Start Game"
    
        let buttonGameInfo = UIButton(type: .system)
        buttonGameInfo.titleEdgeInsets = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
        buttonGameInfo.titleLabel?.text = "Game Info"
        
        let loadSavedGame = UIButton(type: .system)
        loadSavedGame.titleEdgeInsets = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
        loadSavedGame.titleLabel?.text = "Load Saved Game"
        
        buttonStackView.addSubview(buttonStartGame)
        buttonStackView.addSubview(buttonGameInfo)
        buttonStackView.addSubview(loadSavedGame)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        let CurrentSizeClassConfiguration = (newCollection.verticalSizeClass, newCollection.horizontalSizeClass)
        
      
        
        
        //Adjust the axis of the main stack view based on the new trait collection
        
        switch(CurrentSizeClassConfiguration){
            case (.regular,.compact),(.regular,.compact):
                mainStackView.axis = .vertical
                break
            case (.compact,.regular),(.compact,.regular):
                mainStackView.axis = .horizontal
                break
            default:
                break
            
        }
        
        
    
    }
    
    
    //Helper functions for configuring UI Element constraints based on size class
    
    
    
    private func configureButtonStackViewConstraints(forVerticalSizeClass verticalSizeClass: UIUserInterfaceSizeClass, forMainTitleConstraintsIn constraintsArray: inout [NSLayoutConstraint]){
        
        
        
        switch(verticalSizeClass)
        {
        case .compact:
            let rightAnchorConstraint = buttonStackView.leftAnchor.constraint(equalTo: view.rightAnchor)
            let topAnchorConstraint = buttonStackView.topAnchor.constraint(equalTo: view.topAnchor)
            let bottomAnchorConstraint = buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            let widthAnchorConstraint = buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50)
            
            constraintsArray.append(rightAnchorConstraint)
            constraintsArray.append(topAnchorConstraint)
            constraintsArray.append(bottomAnchorConstraint)
            constraintsArray.append(widthAnchorConstraint)
            break
        case .regular:
            let leftAnchorConstraint = mainTitleView.leftAnchor.constraint(equalTo: view.leftAnchor)
            let bottomAnchorConstraint = mainTitleView.topAnchor.constraint(equalTo: view.bottomAnchor)
            let rightAnchorConstraint = mainTitleView.rightAnchor.constraint(equalTo: view.rightAnchor)
            let heightConstraint = mainTitleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.50)
            
            constraintsArray.append(leftAnchorConstraint)
            constraintsArray.append(bottomAnchorConstraint)
            constraintsArray.append(rightAnchorConstraint)
            constraintsArray.append(heightConstraint)
            
            break
        default:
            break
        }

        
    }
    
    private func configureMainTitleConstraints(forVerticalSizeClass verticalSizeClass: UIUserInterfaceSizeClass, forMainTitleConstraintsIn constraintsArray: inout [NSLayoutConstraint]){
        
        switch(verticalSizeClass)
        {
        case .compact:
            let leftAnchorConstraint = mainTitleView.leftAnchor.constraint(equalTo: view.leftAnchor)
            let topAnchorConstraint = mainTitleView.topAnchor.constraint(equalTo: view.topAnchor)
            let bottomAnchorConstraint = mainTitleView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            let widthAnchorConstraint = mainTitleView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50)
            
            constraintsArray.append(leftAnchorConstraint)
            constraintsArray.append(topAnchorConstraint)
            constraintsArray.append(bottomAnchorConstraint)
            constraintsArray.append(widthAnchorConstraint)
            break
        case .regular:
            let leftAnchorConstraint = mainTitleView.leftAnchor.constraint(equalTo: view.leftAnchor)
            let topAnchorConstraint = mainTitleView.topAnchor.constraint(equalTo: view.topAnchor)
            let rightAnchorConstraint = mainTitleView.rightAnchor.constraint(equalTo: view.rightAnchor)
            let heightConstraint = mainTitleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.50)
            
            constraintsArray.append(leftAnchorConstraint)
            constraintsArray.append(topAnchorConstraint)
            constraintsArray.append(rightAnchorConstraint)
            constraintsArray.append(heightConstraint)
            
            break
        default:
            break
        }
    }

    
    
}
