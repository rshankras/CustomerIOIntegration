//
//  CustomerIOWrapper.swift
//  CustomerIOIntegration
//
//  Created by Ravi Shankar on 16/04/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import Foundation

public class CustomerIOWrapper {
    
    enum HTTPMethodType : String {
        case PUT = "PUT"
        case POST = "POST"
    }

    let siteID = "<YOUR_SITE_ID>"
    let key = "<YOUR_KEY>"
    
    func createCustomer(customerID: Int, data:Dictionary<String,String>) {
        let createCustomerURL = "https://track.customer.io/api/v1/customers/\(customerID)"
        postDataToServer(createCustomerURL, data: data, methodType: HTTPMethodType.PUT)
    }
    
    func sendEvent(customerID: Int, data:Dictionary<String,String>) {
        let sendEventURL = "https://track.customer.io/api/v1/customers/\(customerID)/events"
        postDataToServer(sendEventURL, data: data, methodType: HTTPMethodType.POST)
    }
    
    func postDataToServer(url: String, data:Dictionary<String,String>, methodType:HTTPMethodType) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = methodType.rawValue
        request.addValue("Basic " + getBase64AccessKeys() , forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField:"Content-Type")
        request.addValue("application/json", forHTTPHeaderField:"Accept");
        
        var error: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.allZeros, error: &error)
        
        NSURLSession.sharedSession() .dataTaskWithRequest(request, completionHandler: { (data: NSData!, response:NSURLResponse!, error: NSError!) -> Void in
            println(response)
            if error == nil {
            
                var errorPointer : NSErrorPointer = nil
            
                if let results: NSDictionary = NSJSONSerialization .JSONObjectWithData(data, options:   NSJSONReadingOptions.AllowFragments  , error: errorPointer) as? NSDictionary {
                    println("Success")
                }
            } else {
                println(error.localizedDescription)
            }
        }).resume()
    }
    
    func getBase64AccessKeys() -> String {
        
        let accessKeys = siteID + ":" + key
        let accessKeysData: NSData = accessKeys.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64AccessKeyString = accessKeysData.base64EncodedStringWithOptions(nil)
        
        return base64AccessKeyString
    }
}