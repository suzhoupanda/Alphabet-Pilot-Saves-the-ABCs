//
//  HelpDetailController.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit


class HelpDetailController: UIViewController, UIScrollViewDelegate{
    
    typealias QuestionAnswerSet = [[String:String]]
    
    var QASet: QuestionAnswerSet!
    
    var mainStackView: UIStackView!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        let backButton = UIButton(type: .custom)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(HelpDetailController.returnToHelpTopicsMenu), for: .touchUpInside)
        view.addSubview(backButton)
        
        backButton.backgroundColor = UIColor.GetCustomColor(customColor: .BluishGrey)
        
        backButton.titleLabel?.textColor = UIColor.GetCustomColor(customColor: .GrassyGreen)
        backButton.titleLabel?.text = "Back to Help Topics"
        backButton.titleLabel?.font = UIFont(name: "Avenir-HeavyOblique", size: 20.0)
        
        
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        
        NSLayoutConstraint.activate([
            //Configure constraints for navigation bar
            backButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            backButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            backButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            
            //Configure constraints for scroll view
            scrollView.topAnchor.constraint(equalTo: backButton.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
            
            ])
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height*3.0)

        
        mainStackView = UIStackView()
        scrollView.addSubview(mainStackView)
        scrollView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            mainStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor)
            
            ])
        
        scrollView.backgroundColor = UIColor.GetCustomColor(customColor: .SharkFinWhite)
        view.backgroundColor = UIColor.GetCustomColor(customColor: .SharkFinWhite)
        mainStackView.backgroundColor = UIColor.GetCustomColor(customColor: .SharkFinWhite)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillProportionally
        
       mainStackView.backgroundColor = UIColor.GetCustomColor(customColor: .GrassyGreen)
        
        for QADict in QASet{
            
            let questionLabel = UILabel()
            questionLabel.font = UIFont(name: "Avenir-HeavyOblique", size: 20.0)
            questionLabel.textColor = UIColor.GetCustomColor(customColor: .StopSignRed)
            questionLabel.text = QADict["Question"]!
            questionLabel.textAlignment = .left
            questionLabel.numberOfLines = 0
            questionLabel.lineBreakMode = .byWordWrapping
        
            let answerLabel = UILabel()
            answerLabel.font = UIFont(name: "Avenir-Book ", size: 15.0)
            answerLabel.text = QADict["Answer"]!
            answerLabel.textAlignment = .left
            answerLabel.numberOfLines = 0
            answerLabel.lineBreakMode = .byWordWrapping
            
            let QAStackView = UIStackView(arrangedSubviews: [questionLabel, answerLabel])
            QAStackView.backgroundColor = UIColor.GetCustomColor(customColor: .BluishGrey)
            
            QAStackView.axis = .vertical
            QAStackView.distribution = .fillProportionally
            
            mainStackView.addArrangedSubview(QAStackView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
  
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .portrait
    }
    
    func returnToHelpTopicsMenu(){
        dismiss(animated: true, completion: nil)
    }
    
}


//MARK: ScrollViewDelegate Methods

extension HelpDetailController{

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x > 60.00{
            scrollView.setContentOffset(CGPoint(x: 60.0, y: 0.00), animated: true)
        }
      
    }
    
}
