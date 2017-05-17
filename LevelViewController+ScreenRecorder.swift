//
//  BaseScene+ScreenRecorder.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/14/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import ReplayKit
import SpriteKit

extension LevelViewController: RPScreenRecorderDelegate, RPPreviewViewControllerDelegate{
    
    
    func startScreenRecording(notification: Notification){
        
        print("About to start recording...")

        let sharedRecorder = RPScreenRecorder.shared()
        
        sharedRecorder.delegate = self
        
        //Start the recorder; if an error occurs, then an AlertViewController is shown; the handler for errors that occur in starting the recording is asynchronous but the AlertController will be shown on the Main Queue
        
        if sharedRecorder.isRecording{
            
        }
        
        sharedRecorder.startRecording(handler: {
            
            error in
            
            if let error = error{
                self.showScreenRecordingAlert(message: error.localizedDescription)
            }
            
        })
    }
    
    func stopScreenRecording(notification: Notification, withHandler handler: @escaping (() -> Void)){
        
        print("About to stop screen recording...")

        let sharedRecorder = RPScreenRecorder.shared()
        
        if !sharedRecorder.isRecording{
            
            
            
         
        }
        
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
            
            present(alertViewController, animated: true, completion: nil)
            
            return
        }
        
        
        present(previewViewController!, animated: true, completion: nil)
    }

    
    func showScreenRecordingAlert(message: String){
        
      
        //Shows the user that there was an error with starting or stopping the controller
        
        let alertController = UIAlertController(title: "ReplayKit Error", message: message, preferredStyle: .alert)
        
        /** Comments: ... Refactor the handler to allow for the option to restart the recording
         
         **/
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        
       
        present(alertController, animated: true, completion: nil)
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
