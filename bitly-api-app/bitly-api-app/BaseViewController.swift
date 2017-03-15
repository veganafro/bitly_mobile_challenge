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
    
    /*
        This function defines actions that occur after a user confirms that they are finished saving a link
     */
    @IBAction func doneSavingLink(segue: UIStoryboardSegue) {
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "saveLinkSegue" {
            BitlyHelperFunctions.getLinkHistory()
            print(BitlyHelperFunctions.linkHistorySet)
        }
    }

}
