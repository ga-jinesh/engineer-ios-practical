//
//  PostCell.swift
//  JineshTest17082019
//
//  Created by Saumil Patel on 17/08/19.
//  Copyright © 2019 Jinesh Patel. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var viewSeprator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(objPost : Post)
    {
        var date = Util.convertDateFormatter(date: objPost.createdDate!)
        lblDate.setCellUI(txt: date, color: Constant.COLOR.LBL_DATE, txtFont: Constant.FONT.LBL_DATE)
        lblTitle.setCellUI(txt: objPost.title!, color: Constant.COLOR.LBL_TITLE, txtFont: Constant.FONT.LBL_TITLE)
        viewSeprator.backgroundColor = Constant.COLOR.SEPRATOR
    }

}
