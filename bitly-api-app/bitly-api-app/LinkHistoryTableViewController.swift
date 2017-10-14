//
//  LinkHistoryTableViewController.swift
//  bitly-api-app
//
//  Created by Jeremia Muhia on 3/15/17.
//  Copyright © 2017 NYU. All rights reserved.
//

import UIKit

class LinkHistoryTableViewController: UITableViewController {
    
    var bitlinksArray = Array(BitlyHelperFunctions.linkHistorySet)
    var baseURL = "https://api-ssl.bitly.com/v3/user/"
    var accessToken = AppDelegate.globalAccessToken
    var linkHistoryData: [[String:AnyObject]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let endPoint = baseURL + "link_history?access_token=\(accessToken)"
        var request = URLRequest(url: URL(string: endPoint)!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        session.dataTask(with: request) {(data, response, error) -> Void in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:AnyObject]
                    
                    // traverse the levels of JSON nesting to access the link history data
                    let jsonData = json["data"] as! [String:AnyObject]
                    self.linkHistoryData = jsonData["link_history"] as! [[String:AnyObject]]
                    
                    self.tableView.dataSource = self.linkHistoryData as? UITableViewDataSource
                    self.tableView.reloadData()
                    print("$$$ DATA SOURCE RELOADED")
                }
                    
                catch {
                    print("LINK HISTORY JSON SERIALIZATION UNSUCCESSFUL!")
                }
                
            }
        }.resume()
        
        return self.linkHistoryData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // deque a cell to be reused and if a cell is not available for dequeing, initialize a new one
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "tableCell")
        
        // Configure the cell...
        // get a bitlink from the array of bitlinks
//        let bitlink = self.bitlinksArray[indexPath.row]
        
        // label the cell with the bitlink and cell details with the bitlink title
//        cell.textLabel?.text = bitlink
//        cell.detailTextLabel?.text = BitlyHelperFunctions.linkHistoryTable[bitlink]
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
