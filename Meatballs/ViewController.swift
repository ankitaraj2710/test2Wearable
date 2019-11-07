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
    
    @IBOutlet weak var logLabel: UILabel!
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        let timezone:String = message["timezone"]! as! String
        let city:String = message["city"]! as! String
        
        print(timezone)
        print(city)
        
        print("Received a message from the watch: \(message)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
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
    
    
    func callParticleTimeFunction(hour:String){
        //logLabel.text = "Please check particle for time"
        let parameters = [hour]
        print("callParticleTimeFunction: \(hour)")
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


