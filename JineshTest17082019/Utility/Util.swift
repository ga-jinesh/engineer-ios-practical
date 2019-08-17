//
//  Util.swift
//  JineshTest17082019
//
//  Created by Saumil Patel on 17/08/19.
//  Copyright © 2019 Jinesh Patel. All rights reserved.
//

import UIKit
import SVProgressHUD
import Reachability
import SystemConfiguration

class Util: NSObject {
    
    // this method is to show loading while api is calling
    static func showLoading()
    {
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
    }
    
    // this method is to hide loading while api is calling
    static func hideLoading()
    {
        SVProgressHUD.dismiss()
    }
    
    // this method is to convet date format
    static func convertDateFormatter(date: String) -> String
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as! TimeZone
        let date = dateFormatter.date(from: date)
        
        
        dateFormatter.dateFormat = "yyyy MMM EEEE HH:mm"///this is what you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as! TimeZone
        let timeStamp = dateFormatter.string(from: date!)
        
        
        return timeStamp
    }
    
    // this method is to check network is connected or not
    static func isConnectedToNetwork() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }

}

extension UILabel
{
    // this method is to set Cell's label UI like color, font etc
    func setCellUI(txt : String , color : UIColor , txtFont : UIFont)
    {
        self.text = txt
        self.textColor = color
        self.font = txtFont
    }
}

extension UIViewController
{
    // this methods is to show alert to display any message to user
    func showAlert(msg: String) -> Void {
        
        let alertController = UIAlertController(title: "Jinesh Test", message: msg, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK" , style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
