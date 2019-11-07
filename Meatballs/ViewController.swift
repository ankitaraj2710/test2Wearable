//
//  ViewController.swift
//  Meatballs
//
//  Created by MacStudent on 2019-10-16.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import WatchConnectivity
import Particle_SDK


class ViewController: UIViewController ,WCSessionDelegate{
    
    var username:String = "ankitrajkaur@gmail.com"
    var password:String = "ankita2710"
    var id:String = "280042001247363333343437"
    var myPhoton : ParticleDevice?
    var totalTime:Int = 20
    var frameCounter = 0
    @IBOutlet weak var logLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
        if(frameCounter%60 == 0){
            if(totalTime>=1){
                totalTime = totalTime - 1;
                
                timerLabel.text = "Time: \(totalTime)"
            }
        }
        ParticleCloud.init()
        loginInParticle()
        getDeviceFromCloud()
        
    }
    
    
                
                
    

    func loginInParticle(){
        // 2. Login to your account
        ParticleCloud.sharedInstance().login(withUser: self.username, password: self.password) { (error:Error?) -> Void in
            if (error != nil) {
                // Something went wrong!
                print("Wrong credentials or as! ParticleCompletionBlock no internet connectivity, please try again")
                // Print out more detailed information
                print(error?.localizedDescription)
            }
            else {
                print("Login success!")
            }
        }
    }
    func getDeviceFromCloud() {
        ParticleCloud.sharedInstance().getDevice(self.id) { (device:ParticleDevice?, error:Error?) in
            
            if (error != nil) {
                print("Could not get device")
                print(error?.localizedDescription)
                return
            }
            else {
                print("Got photon: \(device?.id)")
                self.myPhoton = device
            }
            
        } // end getDevice()
    
    
    }
    func callParticleTimeFunction(time:String){
        //startButton.text = "Please check particle for time"
        let parameters = [time]
        print("callParticleTimeFunction: \(time)")
        var call = myPhoton!.callFunction("makeShapes", withArguments: parameters) {
            
            (resultCode : NSNumber?, error : Error?) -> Void in
            if (error == nil) {
                print("Sent message to Particle to turn green")
            }
            else {
                print("Error when telling Particle to turn green")
            }
        }
    }
  
                        }


            
            





