//
//  FirstViewController.swift
//  YumBus
//
//  Created by Seungheon Yum on 5/28/16.
//  Copyright © 2016 syumdev. All rights reserved.
//

import UIKit

class ShowBusTimesViewController: UIViewController, NSXMLParserDelegate {

    
    var _parser = NSXMLParser()
    var _element = NSString()
    let _url = NSURL(string:"http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=mbta&r=66&s=1111")
    var _secondsArray: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        parseNextBus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseNextBus() {
        _parser = (NSXMLParser(contentsOfURL: _url!))!
        _parser.delegate=self
        _parser.parse()
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        _element = elementName
        if _element == "prediction" {
            let seconds = attributeDict["seconds"]
            _secondsArray.append(seconds!)
        }
    }

}

