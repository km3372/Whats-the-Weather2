//
//  ViewController.swift
//  Whats the Weather
//
//  Created by kenneth moody on 12/6/17.
//  Copyright © 2015 iMoody Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityTextsField: UITextField!
    
    
    @IBOutlet var resultLabel: UILabel!
    
    
    
    @IBAction func findWeather(_ sender: AnyObject) {
        
        let attemptedUrl = URL(string: "http://www.weather-forecast.com/locations/" + cityTextsField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest")
        
        var wasSuccessful = false
        
        if let url = attemptedUrl {
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: String.Encoding.utf8.rawValue)
                
                let websiteArray = webContent!.components(separatedBy: "3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")

                
                if websiteArray.count > 1 {
                    
                    
                    let weatherArray = websiteArray[1].components(separatedBy: "</span")
                    
                    if weatherArray.count > 1 {
                        
                        wasSuccessful = true
                        
                        let weatherSummary = weatherArray[0].replacingOccurrences(of: "&deg;", with: "º")
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.resultLabel.text = weatherSummary
                        })
                    }
                    
                }
            }
            
                if wasSuccessful == false {
                    
                    self.resultLabel.text = "Couldn't find the weather for the city or check your selling - please try again."
                }
        }) 
        
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
        
        cityTextsField.resignFirstResponder()
        return true
    }

}

