//
//  FirstViewController.swift
//  YumBus
//
//  Created by Seungheon Yum on 5/28/16.
//  Copyright © 2016 syumdev. All rights reserved.
//

import UIKit

class ShowBusTimesViewController: UIViewController, NSXMLParserDelegate, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var _tableView: UITableView!
    
    var _parser = NSXMLParser()
    var _element = NSString()
    let _url = NSURL(string:"http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=mbta&r=66&s=1111")
    var _secondsArray: [String] = []
    let _cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseNextBus()
        
        self._tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: _cellReuseIdentifier)
        _tableView.delegate=self
        _tableView.dataSource=self
        for element in _secondsArray {
            print(element)
        }
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
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView:UITableView!, numberOfRowsInSection section:Int) -> Int
    {
        print(_secondsArray.count)
        return _secondsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self._tableView.dequeueReusableCellWithIdentifier(_cellReuseIdentifier) as UITableViewCell!
       
        cell.textLabel?.text = self._secondsArray[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    
    
}

