//
//  Constant.swift
//  JineshTest17082019
//
//  Created by Saumil Patel on 17/08/19.
//  Copyright © 2019 Jinesh Patel. All rights reserved.
//

import UIKit

class Constant: NSObject {

    struct API {
        static let BASE_URL = "https://hn.algolia.com/"
        static let SEARCH_BY_DATE = "api/v1/search_by_date"
    }
    
    struct CELL_IDENTIFIER {
        static let POST_CELL_IDENTIFIER = "PostCell"
    }
    
    struct COLOR {
        static let SEPRATOR = UIColor.lightGray
        static let LBL_DATE = UIColor.green
        static let LBL_TITLE = UIColor.blue
        static let LBL_COMMON_MESSAGE = UIColor.black
    }
    
    struct FONT {
        static let LBL_DATE = UIFont.systemFont(ofSize: 15)
        static let LBL_TITLE = UIFont.boldSystemFont(ofSize: 17)
        static let LBL_COMMON_MESSAGE = UIFont.systemFont(ofSize: 17)
    }
    
    struct ALERT {
        static let INTERNET_CONNECTION = "Please check internet connection"
    }
    
    struct TITLE {
        static let LOADING = "Loading..."
        static let TOTAL_COUNT = "Total Count"
    }
    
}

