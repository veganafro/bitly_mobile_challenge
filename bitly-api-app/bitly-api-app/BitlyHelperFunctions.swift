//
//  BitlyHelperFunctions.swift
//  bitly-api-app
//
//  Created by Jeremia Muhia on 3/14/17.
//  Copyright © 2017 NYU. All rights reserved.
//

import UIKit
import BitlySDK

/*
    This file contains globally used helper functions that communicate with the Bitly API endpoints.
    The project is architected in this way to separate UI logic from backend logic.
 */
class BitlyHelperFunctions: NSObject {

    /*
        The function below uses the /v3/user/link_save endpoint of the Bitly API to save a long URL
        as a Bitlink in a user's history.
     
        @param longURL
            - this is the URL that will be saved as a Bitlink
     
        @param title
            - the title of the Bitlink associated with longURL
     */
    static func linkSave(longURL: String, title: String) {
    
        
    }
}
