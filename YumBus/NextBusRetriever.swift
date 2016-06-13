//
//  NextBusRetriever.swift
//  YumBus
//
//  Created by Seungheon Yum on 6/12/16.
//  Copyright © 2016 syumdev. All rights reserved.
//

import Foundation

class NextBusRetriever: NSObject, NSXMLParserDelegate {
    var agency: String
    var route: String
    var stop: String
    var url: NSURL
    
    var element = NSString()
    var secondsArray: [String] = []
    
    //var delegate:NSXMLParserDelegate
    var parser = NSXMLParser()
    
    
   
    
    init(agency: String, route:String, stop:String){
        self.agency = agency
        self.route = route
        self.stop = stop
        var baseUrl = "http://webservices.nextbus.com/service/publicXMLFeed?command=predictions"
        baseUrl += "&a=" + agency
        baseUrl += "&r=" + route
        baseUrl += "&s=" + stop
        
        self.url = NSURL(string:baseUrl)!
        
    }
    

    func parseNextBus() {
        self.parser = (NSXMLParser(contentsOfURL: self.url))!
        self.parser.delegate = self
        self.parser.parse()
    }
    
    @objc func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        print("parser")
        self.element = elementName
        if self.element == "prediction" {
            let seconds = attributeDict["seconds"]
            self.secondsArray.append(seconds!)
        }
    }
    
    func printSecondsArray(){
        print("hi")
        for seconds in self.secondsArray {
            print(seconds)
        }
    }
    
    func removeAll(){
        self.secondsArray.removeAll()
    }
    
}