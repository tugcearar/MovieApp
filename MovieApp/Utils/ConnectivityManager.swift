//
//  ConnectivityManager.swift
//  MovieApp
//
//  Created by Tuğçe Arar on 2.04.2022.
//

import Foundation
import Network

class ConnectivityManager{
    static let sharedInstance = ConnectivityManager()
    private var monitor:NWPathMonitor?
    private var isMonitoring = false;
    
    var didStartMonitoringHandler: (()-> Void)?
    var didStopMonitoringHandler: (()-> Void)?
    var netStatusChangeHandler: (()-> Void)?
    
    var isConnected: Bool {
        guard let monitor = monitor else {
            return false
        }
        return monitor.currentPath.status == .satisfied

    }
    
    var networkType: NWInterface.InterfaceType? {
        guard let _ = monitor else { return nil }
        return self.availableTypes?.first
    }
    
    private var availableTypes: [NWInterface.InterfaceType]? {
        guard let monitor = monitor else {
            return nil
        }
        return monitor.currentPath.availableInterfaces.map{ $0.type }

    }
    
    private init() {
    
    }
    
    func startChecking(){
        monitor = NWPathMonitor()
        let queue =  DispatchQueue(label: "Monitor")
        monitor?.start(queue: queue)
        monitor?.pathUpdateHandler = {_ in
            self.netStatusChangeHandler?()
            
        }
        isMonitoring=true
        didStartMonitoringHandler?()
    }
    
    func stopChecking(){
        if isMonitoring, let monitor = monitor{
            monitor.cancel()
            self.monitor=nil
            isMonitoring=false
            didStopMonitoringHandler?()
        }
    }
    
    deinit{
        stopChecking()
    }
    
}
