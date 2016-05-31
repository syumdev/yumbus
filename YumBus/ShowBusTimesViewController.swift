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
    var _refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseNextBus()
        setTableView()
        refreshControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseNextBus() {
        _parser = (NSXMLParser(contentsOfURL: _url!))!
        _parser.delegate=self
        _parser.parse()
        for element in _secondsArray {
            print(element)
        }
    }
    
    func setTableView(){
        self._tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: _cellReuseIdentifier)
        _tableView.delegate=self
        _tableView.dataSource=self
    }
    
    func refreshControl(){
        _refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        _refreshControl.addTarget(self, action: "refreshTableView", forControlEvents: UIControlEvents.ValueChanged)
        _tableView?.addSubview(_refreshControl)
        
        
    }
    
    func refreshTableView(){
        _secondsArray.removeAll()
        parseNextBus()
        _tableView.reloadData()
        
        let delayInSeconds = 0.5;
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)));
        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            self._refreshControl.endRefreshing()
        }
    }
    
    func setRefreshControl(){
        self.refreshTableView()
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
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return _secondsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self._tableView.dequeueReusableCellWithIdentifier(_cellReuseIdentifier) as UITableViewCell!
        cell.textLabel?.text = secondsToMinuteSeconds(self._secondsArray[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func secondsToMinuteSeconds(time: String) -> String {
        return String(Int(time)!/60)+" min"
    }
    
    
    
}

