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
    
    // we have a global base URL that can be used to reach specific API endpoints
    static var baseURL = "https://api-ssl.bitly.com/v3/user/"
    static var accessToken = AppDelegate.globalAccessToken
    
    // create a set to store the Bitlinks in a user's history
    // this is done to assure no duplicate data will be displayed
    static var linkHistorySet = Set<String>()
    
    /*
        The function below uses the /v3/user/link_save endpoint of the Bitly API to save a long URL
        as a Bitlink in a user's history.
     
        @param longURL
            - this is the URL that will be saved as a Bitlink
     
        @param title
            - the title of the Bitlink associated with longURL
     */
    static func linkSave(longURL: String, title: String) {
        
        // begin by creating the full length endpoint that should be accessed
        let endPoint = baseURL + "link_save?access_token=\(accessToken)&longUrl=\(longURL)"
        
        // create a URLRequest object that creates a GET request to the endpoint created above
        var request = URLRequest(url: URL(string: endPoint)!)
        request.httpMethod = "GET"
        
        // create a background task using the URLSession class
        let session = URLSession.shared
        
        // create a task that retrieves the contents at the specified URL
        session.dataTask(with: request) {
            
            // after retrieving the contents of the URL, handle the returned values with this completion handler
            (data, response, error) -> Void in
            
            // cast the URLResponse? object to a HTTPURLResponse and get the status code returned after making
            // the GET request specified above
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            // if the status code returned is 200, everthing went well
            if (statusCode == 200) {
                print("LINK SAVE GET REQUEST SUCCESSFULL")
            }
            else {
                print("LINK SAVE GET REQUEST UNSUCCESSFULL - \(statusCode)")
            }
            
            // resume the task if it has been suspended
        }.resume()
    }
    
    /*
        This function uses /v3/user/link_history endpoint of the Bitly API to get a user's Bitlink
        history in reverse chronological order
     */
    static func linkHistory() {
    
    }
}
