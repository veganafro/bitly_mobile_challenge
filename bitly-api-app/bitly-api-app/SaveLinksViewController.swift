//
//  SaveLinksViewController.swift
//  bitly-api-app
//
//  Created by Jeremia Muhia on 3/14/17.
//  Copyright © 2017 NYU. All rights reserved.
//

import UIKit

/*
    This class defines behaviors for the SaveLinks view controller
 */
class SaveLinksViewController: UIViewController {

    /*
        Create variables linked to the two text fields on the SaveLinks view controller
     */
    
    @IBOutlet weak var longURLTextField: UITextField!
    @IBOutlet weak var urlTitleTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
        This function defines what occurs when the user taps the done, indicating that they want to save a link
     */
    @IBAction func didTapDoneButton(_ sender: Any) {
        
        // add a print statement for debugging
        print("DONE BUTTON PRESSED")
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
