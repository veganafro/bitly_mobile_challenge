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
    static var linkHistoryTable = Dictionary<String, String>()
    
    // keep a viriable to the total number of clicks for all Bitlinks
    static var totalClicks: Int = 0
    
    /*
        The function below uses the /v3/user/link_save endpoint of the Bitly API to save a long URL
        as a Bitlink in a user's history.
     
        @param longURL
            - this is the URL that will be saved as a Bitlink
     
        @param title
            - the title of the Bitlink associated with longURL
     
        @return Void
            - this function does not return any values
     */
    static func linkSave(longURL: String, title: String) -> Void {
        
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
     
        @return - Void
            - this function does not have any return values
     */
    static func getLinkHistory() -> Void {
        
        // begin by creating the full length endpoint that should be accessed
        let endPoint = baseURL + "link_history?access_token=\(accessToken)"
        
        // create a URLRequest object that creates a GET request to the endpoint created above
        var request = URLRequest(url: URL(string: endPoint)!)
        request.httpMethod = "GET"
        
        // create a background task using the URLSession class
        let session = URLSession.shared
        
        // create a task that retrieves the contents at the specified URL
        session.dataTask(with: request) {
            
            // after retrieving the contets of the URL, handle the returned values with this completion handler
            // iterate over the data and store the bitlinks in the linkHistorySet data structure
            (data, response, error) -> Void in
            
            // cast the URLResponse? object to a HTTPURLResponse and get the status code returned after making
            // the GET request specified above
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            // if the status code returned is 200, everthing went well so load the Bitlink into the set
            if (statusCode == 200) {
            
                // try to interpret the returned JSON object
                do {
                    
                    // create a variable to store pretty printed JSON
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:AnyObject]
                    
                    // traverse the levels of JSON nesting to access the link history data
                    let jsonData = json["data"] as! [String:AnyObject]
                    let linkHistoryData = jsonData["link_history"] as! [[String:AnyObject]]
                    
                    // iterate over each Bitlink that is represented as a dictionary and store the links in the set
                    for link in linkHistoryData {
                    
                        // create a variable to store the link and title then insert them into the set and dictionary
                        let bitlink = link["link"] as! String
                        let title = link["title"] as! String
                        
                        print(bitlink)
                        print(title)
                        
                        linkHistoryTable[bitlink] = title
                        linkHistorySet.insert(bitlink)
                    }
                }
                // catch any errors and print debugging statement
                catch {
                    print("LINK HISTORY JSON SERIALIZATION UNSUCCESSFULL")
                }
            }
            
            // resume the task if it has been suspended
        }.resume()
    }
    
    /*
        This function uses the /v3/user/clicks endpoint of the Bitly API to get the aggregate number of clicks
        on all the of the user's links
     
        @return Int
            - this function does not have a return value
     */
    static func getLinkClicks() -> Void {
        
        // begin by creating the full length endpoint that should be accessed
        let endPoint = baseURL + "clicks?access_token=\(accessToken)"
        
        // create a URLRequest object that creates a GET request to the endpoint created above
        var request = URLRequest(url: URL(string: endPoint)!)
        request.httpMethod = "GET"
        
        // create a background task using the URLSession class
        let session = URLSession.shared
        
        // create a task that retrieves the contents at the specified URL
        session.dataTask(with: request) {
            
            // after retrieving the contets of the URL, handle the returned values with this completion handler
            // iterate over the data and store the bitlinks in the linkHistorySet data structure
            (data, response, error) -> Void in
            
            // cast the URLResponse? object to a HTTPURLResponse and get the status code returned after making
            // the GET request specified above
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            // if the status code returned is 200, everthing went well so load the Bitlink into the set
            if (statusCode == 200) {
                
                // try to interpret the returned JSON object
                do {
                    
                    // create a variable to store pretty printed JSON
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:AnyObject]
                    
                    // traverse the levels of JSON nesting to access the link click data
                    let jsonData = json["data"] as! [String:AnyObject]
                    
                    // update the count of clicks using the value stored at 'total_clicks'
                    totalClicks = jsonData["total_clicks"]! as! Int
                }
                catch{
                    print("LINK CLICKS JSON SERIALIZATION USUCCSESSFULL")
                }
            }
            
            // resume the task if it's been suspended
        }.resume()
    }
}
