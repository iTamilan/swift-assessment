//
//  APIClient.swift
//  Assessment
//
//  Created by Tamilarasu on 12/04/2017.
//  Copyright © 2017 iTamilan. All rights reserved.
//

import UIKit

let kAPIUrlGetAssessment = URL(string:"")!
let kAPIUrlSubmitAssessment = URL(string:"")!
typealias CompletionHandler = (Bool?,String?,Error?) -> Void
class APIClient: NSObject, XMLParserDelegate {
    //Get Request
    private func commonResponseHandler(data:Data?,response:URLResponse?,error:Error?,completionHandler:@escaping CompletionHandler){
        var statuscode = 0
        //Finding the status code
        if let httpResponse = response as? HTTPURLResponse {
            statuscode = httpResponse.statusCode
        }
        print("API Response:",response ?? "",error ?? "")
        let status = statuscode == 200 || statuscode == 201
        //Checking for error
        guard error == nil else {
            completionHandler(status,nil,error)
            return
        }
        //Checking for empty response
        guard let data = data else {
            completionHandler(status,nil,error)
            return
        }
        let responseStr = String(data:data, encoding: .utf8) ?? ""
        print("API Response xml string :",responseStr,"\n\n\n")
        completionHandler(status,responseStr,error)
    }
    private func httpRequestGET(url:URL, completionHandler:@escaping CompletionHandler){
        var request = URLRequest.init(url: url)
        //setting the content type
        request.addValue("application/xml", forHTTPHeaderField: "Content-Type")
        //setting http method
        request.httpMethod = "GET"
        //Requesting
        print("API REQUEST----GET---:",request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.commonResponseHandler(data:
                data, response: response, error: error, completionHandler: completionHandler)
        }
        
        task.resume()
    }
    private func httpRequestPOST(url:URL,xmlString:String,completionHandler:@escaping CompletionHandler){
        var request = URLRequest.init(url: url)
        //setting the content type
        request.addValue("application/xml", forHTTPHeaderField: "Content-Type")
        //setting http method
        request.httpMethod = "POST"
        //setting Http Body
        request.httpBody = xmlString.data(using: .utf8)
        //Requesting
        print("API REQUEST----POST---:",request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.commonResponseHandler(data:
                data, response: response, error: error, completionHandler: completionHandler)
        }
        task.resume()
    }
    //MARK: Public Static Methods
    static func getAssessment(completionHandler:@escaping CompletionHandler){
        APIClient.init().httpRequestGET(url: kAPIUrlGetAssessment, completionHandler: completionHandler)
    }
    static func submitAssessment(xmlString:String,completionHandler:@escaping CompletionHandler){
        APIClient.init().httpRequestPOST(url: kAPIUrlSubmitAssessment, xmlString: xmlString, completionHandler: completionHandler)
    }
}
