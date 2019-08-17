//
//  RequestHelper.swift
//  JineshTest17082019
//
//  Created by Saumil Patel on 17/08/19.
//  Copyright © 2019 Jinesh Patel. All rights reserved.
//

import UIKit

typealias ReqCompletionBlock = (_ resObj : NSObject) ->Void

class RequestHelper: NSObject, NetworkAsyncRequestDelegate {

    private var completionBlock:ReqCompletionBlock = { resObj in }
    
    //MARK:- API Response
    func NetworkAsyncRequestDelegate(_ action: String, responseData: Response) {
        
        var dicResponse = responseData.resposeObject as! [String:Any]
        
        if (action == Constant.API.SEARCH_BY_DATE) {
//            ((dicResponse["hits"] as! NSArray)[0] as! NSDictionary)["title"] as! String
            let objPost = Post()
            
            if dicResponse["hits"] != nil
            {
                if let arr = dicResponse["hits"]
                {
                    let arrHits = arr as! NSArray
                    objPost.arrPost = [Post]()
                    
                    for i in 0..<arrHits.count
                    {
                        let objPostData = Post()
                        
                        let dicPost = arrHits[i] as! NSDictionary
                        if let title = dicPost["title"]
                        {
                            objPostData.title = title as? String
                        }
                        if let createdDate = dicPost["created_at"]
                        {
                            objPostData.createdDate = createdDate as? String
                        }
                        objPost.arrPost?.append(objPostData)
                    }
                }
            }
            if dicResponse["exhaustiveNbHits"] != nil
            {
                if dicResponse["exhaustiveNbHits"] as! Bool == false
                {
                    objPost.isNextAvailable = true
                }
                else
                {
                    objPost.isNextAvailable = false
                }
            }
            completionBlock(objPost as NSObject)
        }
    }
    
    //MARK:- API Request Call
    
    func fetchPostData(objPost : Post , resBlock:  @escaping ReqCompletionBlock)
    {
        completionBlock = resBlock
        
        let request = Request()
        request.dictQueryValues["tags"] = "story"
        request.dictQueryValues["page"] = "\(objPost.pageCount!)"
        
        let asyncRequest = NetworkAsyncRequest()
        asyncRequest.delegate = self
        asyncRequest.sendGetRequestWithParams(Constant.API.SEARCH_BY_DATE, requestData: request)
    }
    
}
