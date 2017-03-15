//
//  BaseViewController.swift
//  bitly-api-app
//
//  Created by Jeremia Muhia on 3/14/17.
//  Copyright © 2017 NYU. All rights reserved.
//

import UIKit

/*
    This class defines behaviors the initial view controller
 */
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // because HTTP requests are executed on background threads, recalculate data each time the view appears
        // this way, when the user asks to see data, it is the most recently refreshed data possible
        BitlyHelperFunctions.getLinkHistory()
        BitlyHelperFunctions.getLinkClicks()
    }
    
    /*
        This function defines actions that occur after a user taps the 'link clicks' button
     */
    @IBAction func didTapLinkClicks(_ sender: Any) {
        
        // save the total clicks on all Bitlinks over the past 7 days
        let clicks = BitlyHelperFunctions.totalClicks
        
        // create a title and message that will let the user know how many clicks their bitlinks have
        let title = "Total clicks in the past 7 days"
        let message = "\(clicks)"
        
        // create an alert object that will be presented
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // add an action for users to interact with to the alert
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // present the alert
        self.present(alert, animated: true, completion: nil)
    }
    /*
        This function defines actions that occur after a user confirms that they are finished saving a link
     */
    @IBAction func doneSavingLink(segue: UIStoryboardSegue) {
        
        // because HTTP requests are executed on background threads, recalculate data each time the view appears
        // this way, when the user asks to see data, it is the most recently refreshed data possible
        BitlyHelperFunctions.getLinkHistory()
        BitlyHelperFunctions.getLinkClicks()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
