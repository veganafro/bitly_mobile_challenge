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
        
        // if the user did not enter any text into the text field, send an alert asking them to do so
        if (longURLTextField.text! == "" || urlTitleTextField.text! == "") {
            
            // create a title and alert for the alert that will be displayed
            let title = "Something went wrong"
            let message = "Please enter a valid URL and title above"
            
            // create an alert object that will be presented
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            // add an action for users to interact with to the alert
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            // present the alert
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
