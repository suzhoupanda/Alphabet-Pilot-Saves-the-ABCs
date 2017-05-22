//
//  ScreenRecorderManager.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/17/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import ReplayKit

class ScreenRecorderHelper: NSObject, RPScreenRecorderDelegate, RPPreviewViewControllerDelegate{
    
    
    static let sharedHelper = ScreenRecorderHelper()
    
    
    private let sharedRecorder =  RPScreenRecorder.shared()
    
    var presentingViewController: UIViewController?
    
    
    override init(){
        
        super.init()
        
        sharedRecorder.delegate = self
        
    
    }
    
    var previewViewController: RPPreviewViewController?
    
    
    func startScreenRecording(){
        
        print("About to start recording...")
        
        
        //Start the recorder; if an error occurs, then an AlertViewController is shown; the handler for errors that occur in starting the recording is asynchronous but the AlertController will be shown on the Main Queue
        
        if sharedRecorder.isRecording{
            
            let alertController = UIAlertController(title: "Warning: Recording in Progress", message: "A recording is already in progress. Do you want to stop recording?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            let stopRecordingAction = UIAlertAction(title: "Stop Recording", style: .default, handler: {
                
                _ in
                
                self.stopRecordingAndSavePreviewViewController()
                
                return
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(stopRecordingAction)
            
         
            if let presentingViewController = presentingViewController{
                presentingViewController.present(alertController, animated: true, completion: nil)
            }
            
            
        }
        
        startRecordingAndShowErrorMessageIfNecessary()
        
        
    }
    
    func stopScreenRecording(withHandler handler: @escaping (() -> Void)){
        
        print("About to stop screen recording...")
        
        

        let sharedRecorder = RPScreenRecorder.shared()
        
        if !sharedRecorder.isRecording{
            
            let alertController = UIAlertController(title: "Warning: No Recording in Progress", message: "There is no recording in progress. Do you want to start recording?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            let startRecordingAction = UIAlertAction(title: "Start Recording", style: .default, handler: {
                
                _ in
                
                self.startRecordingAndShowErrorMessageIfNecessary()
                
                return
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(startRecordingAction)
            
            if let presentingViewController = presentingViewController{
                presentingViewController.present(alertController, animated: true, completion: nil)
            }
            
            
        }
        
        stopRecordingAndSavePreviewViewController()
        
        
    }
    
    func startRecordingAndShowErrorMessageIfNecessary(){
        
        
        
        let sharedRecorder = RPScreenRecorder.shared()
        
        sharedRecorder.startRecording(handler: {
            
            error in
            
            if let error = error{
                self.showScreenRecordingAlert(message: error.localizedDescription)
            }
            
        })
    }
    
    func stopRecordingAndSavePreviewViewController(){
     
        if !sharedRecorder.isRecording { return }
        
        sharedRecorder.stopRecording(handler: {
            previewViewController, error in
            
            if let error = error{
                self.showScreenRecordingAlert(message: error.localizedDescription)
                return
            }
            
            if let previewViewController = previewViewController{
                previewViewController.previewControllerDelegate = self
                
                self.previewViewController = previewViewController
            }
            
            
        })
    }
    
    func showPreviewViewController(){
        
        print("About to show preview controller...")
        
        guard previewViewController != nil else {
            
            let alertViewController = UIAlertController(title: "No Recording Available", message: "You have not recorded any game scenes yet.", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertViewController.addAction(cancelAction)
            
            
            if let presentingViewController = presentingViewController{
                presentingViewController.present(alertViewController, animated: true, completion: nil)

            }
            
            return
        }
        
        if let presentingViewController = presentingViewController{
            
            presentingViewController.present(previewViewController!, animated: true, completion: nil)
        }
        
    }
    
    
    func showScreenRecordingAlert(message: String){
        
        
        //Shows the user that there was an error with starting or stopping the controller
        
        let alertController = UIAlertController(title: "ReplayKit Error", message: message, preferredStyle: .alert)
        
        /** Comments: ... Refactor the handler to allow for the option to restart the recording
         
         **/
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        
        
        if let presentingViewController = presentingViewController{
            
            presentingViewController.present(alertController, animated: true, completion: nil)

        }
    }
    
    
    
    
    //RPScreenRecorderDelegate
    
    func screenRecorder(_ screenRecorder: RPScreenRecorder, didStopRecordingWithError error: Error, previewViewController: RPPreviewViewController?) {
        
        //If any error occurs while recording the GamePlay, display the alert message to the user
        showScreenRecordingAlert(message: error.localizedDescription)
        
        //Store a reference to the previewViewController that can be displayed when the user presses the preview button
        if previewViewController != nil{
            self.previewViewController = previewViewController
        }
    }
    
    //RPPreviewViewControllerDelegate
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        previewViewController?.dismiss(animated: true, completion: {})
        
    }
    

   
}
