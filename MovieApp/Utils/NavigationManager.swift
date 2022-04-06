//
//  NavigartionManager.swift
//  MovieApp
//
//  Created by Tuğçe Arar on 2.04.2022.
//

import Foundation
import UIKit

struct NavigationManager{
    func openView(storyboard:String,viewController:String){
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let controller =  storyboard.instantiateViewController(withIdentifier: viewController)
        UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController = controller
    }
    
    
    func displayAlert(title:String,description:String){
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
