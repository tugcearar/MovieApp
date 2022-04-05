//
//  SplashViewController.swift
//  MovieApp
//
//  Created by Tuğçe Arar on 2.04.2022.
//

import UIKit
import Firebase

class SplashViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var remoteConfig: RemoteConfig!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !ConnectivityManager.sharedInstance.isConnected {
            NavigationManager().displayAlert(title: "Connection Error", description: "Seems like you have not connected to internet :( ")
        }
        else{
            fetchRemoteConfig()
        }
        ConnectivityManager.sharedInstance.stopChecking()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    func fetchRemoteConfig(){
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                self.remoteConfig.activate { changed, error in
                    
                }
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
            self.displayValue()
        }
    }
    
    func displayValue(){
        if let value = remoteConfig.configValue(forKey: "loodos").stringValue {
            self.view.backgroundColor = .systemPink
            label.text = value
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                let nm = NavigationManager()
                nm.openView(storyboard: "Main",viewController: "MainVC")
            }
        }
    }
}
