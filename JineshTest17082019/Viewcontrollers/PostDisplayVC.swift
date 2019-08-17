//
//  PostDisplayVC.swift
//  JineshTest17082019
//
//  Created by Saumil Patel on 17/08/19.
//  Copyright © 2019 Jinesh Patel. All rights reserved.
//

import UIKit

class PostDisplayVC: UIViewController {
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tblView: UITableView!
    
    var footerView = UIView()
    
    var arrPost = [Post]()
    var pageCount = 0
    var isAPICalling = false
    var isNextAvailable = true
    
    //MARK:- UIviewcontroller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()

    }
    
    //MARK:- Custom methods
    
    // this method is for showing footerview
    func setFooterView()
    {
        footerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.footerView.frame.width, height: self.footerView.frame.height))
        lbl.setCellUI(txt: Constant.TITLE.LOADING, color: Constant.COLOR.LBL_COMMON_MESSAGE, txtFont: Constant.FONT.LBL_COMMON_MESSAGE)
        lbl.textAlignment = .center
        footerView.addSubview(lbl)
        self.tblView.tableFooterView = footerView
    }
    
    // this method is for hiding footerview
    func hideFooterView()
    {
        self.tblView.tableFooterView = nil
    }
    
    // this methods is for setting initial ui
    func setUpUI()
    {
        self.navigationBar.topItem?.title = Constant.TITLE.TOTAL_COUNT
        if isAPICalling == false
        {
            if Util.isConnectedToNetwork()
            {
                Util.showLoading()
                fetchPostData()
            }
            else
            {
                showAlert(msg: Constant.ALERT.INTERNET_CONNECTION)
            }
        }
    }
    
    // this method is to set navigation bar value
    func updateNavigationBarCount()
    {
        self.navigationBar.topItem?.title = "\(Constant.TITLE.TOTAL_COUNT) : \(arrPost.count)"
    }
    
    // MARK: - API Call Methods

    func fetchPostData()
    {
        self.isAPICalling = true
        self.pageCount += 1
        let objReqHelper = RequestHelper()
        let objPost = Post()
        objPost.pageCount = self.pageCount
        if pageCount != 1
        {
            setFooterView()
        }
        objReqHelper.fetchPostData(objPost: objPost) { (resObj) in
            Util.hideLoading()
            self.hideFooterView()
            self.isAPICalling = false
            
            if let objPost = resObj as? Post {
                if let isNext = objPost.isNextAvailable as? Bool
                {
                    if isNext == false
                    {
                        self.isNextAvailable = false
                    }
                }
                if let arr = objPost.arrPost as? [Post]
                {
                    for i in 0..<arr.count
                    {
                        self.arrPost.append(arr[i])
                    }
                    self.tblView.reloadData()
                    self.updateNavigationBarCount()
                }
            }
        }
    }
   
}

extension PostDisplayVC : UITableViewDataSource , UITableViewDelegate
{
    //MARK:- UITableview methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: Constant.CELL_IDENTIFIER.POST_CELL_IDENTIFIER) as! PostCell
        cell.loadCell(objPost: arrPost[indexPath.row])
        if indexPath.row == (arrPost.count - 2) // When last second cell will execute
        {
            if isAPICalling == false && isNextAvailable == true
            {
                if Util.isConnectedToNetwork()
                {
                    fetchPostData()
                }
                else
                {
                    showAlert(msg: Constant.ALERT.INTERNET_CONNECTION)
                }
            }
        }
        return cell
    }
    
    
    
}
