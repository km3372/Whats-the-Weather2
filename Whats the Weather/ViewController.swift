//
//  ViewController.swift
//  Whats the Weather
//
//  Created by kenneth moody on 12/6/15.
//  Copyright © 2015 iMoody Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityTextsField: UITextField!
    
    
    @IBOutlet var resultLabel: UILabel!
    
    
    
    @IBAction func findWeather(sender: AnyObject) {
        
        let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextsField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        var wasSuccessful = false
        
        if let url = attemptedUrl {
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if websiteArray.count > 1 {
                    
                    
                    let weatherArray = websiteArray[1].componentsSeparatedByString("</span")
                    
                    if weatherArray.count > 1 {
                        
                        wasSuccessful = true
                        
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.resultLabel.text = weatherSummary
                        })
                    }
                    
                }
            }
            
                if wasSuccessful == false {
                    
                    self.resultLabel.text = "Couldn't find the weather for the city - please try again."
                }
                
            
        }
        
        task.resume()
      
        } else {
            
            self.resultLabel.text = "Check your selling - please try again."
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        cityTextsField.resignFirstResponder()
        return true
    }

}

