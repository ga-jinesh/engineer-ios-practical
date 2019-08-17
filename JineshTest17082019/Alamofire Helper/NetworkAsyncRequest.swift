//
//  NetworkAsyncRequest.swift
//  JineshTest17082019
//
//  Created by Saumil Patel on 17/08/19.
//  Copyright © 2019 Jinesh Patel. All rights reserved.
//

import UIKit
import Alamofire

@objc protocol NetworkAsyncRequestDelegate: NSObjectProtocol {
    @objc func NetworkAsyncRequestDelegate(_ action: String, responseData: Response)
}

class NetworkAsyncRequest: NSObject {

    var delegate: NetworkAsyncRequestDelegate? = nil
    var strAction:String = String()
    
    // this method is for get request with parameters
    func sendGetRequestWithParams(_ action: String, requestData: Request) {
        
        strAction = action
        var strQueryString = ""
        
        var i = 1
        for (param,value) in requestData.dictQueryValues {
            
            if i == requestData.dictQueryValues.count {
                strQueryString += param + "=" + value
            }
            else {
                strQueryString += param + "=" + value + "&"
            }
            i += 1
        }
        let strUrl = Constant.API.BASE_URL +  action + (strQueryString.count > 0 ? "?" + strQueryString : "")
        
        print("URL Action :" + strUrl)
        Alamofire.request(strUrl, method: .get, parameters: requestData.dictParamValues, headers: requestData.dictHeaderValues).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                let statusCode = (response.response?.statusCode)!
                print("STATUS CODE : \(statusCode)")
                let responsedictionary = (response.result.value as! [String:Any])
                let response = Response()
                response.resposeObject = responsedictionary
                
                if (self.delegate?.responds(to: #selector(NetworkAsyncRequestDelegate.NetworkAsyncRequestDelegate(_:responseData:))))!{
                    self.delegate?.NetworkAsyncRequestDelegate(self.strAction, responseData: response)
                }
                break
                
            case .failure(_):
                let response = Response()
                if (self.delegate?.responds(to: #selector(NetworkAsyncRequestDelegate.NetworkAsyncRequestDelegate(_:responseData:))))!{
                    self.delegate?.NetworkAsyncRequestDelegate(self.strAction, responseData: response)
                }
                break
            }
        }
    }
    
}
