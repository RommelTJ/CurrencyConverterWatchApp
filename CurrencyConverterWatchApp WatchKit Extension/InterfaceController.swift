//
//  InterfaceController.swift
//  CurrencyConverterWatchApp WatchKit Extension
//
//  Created by Rommel Rico on 3/31/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

import WatchKit
import Foundation

var activeCurrency = 0
var currencies = ["MXN", "GBP", "EUR", "JPY"]
var currencyConversions = [14.50, 0.7, 0.8, 0.9]

class InterfaceController: WKInterfaceController, NSXMLParserDelegate {
    
    var element = ""
    var nameAttribute = ""
    var getCurrency = -1
    
    @IBOutlet weak var currencyLabel: WKInterfaceLabel!
    
    @IBAction func changeCurrencySlider(value: Float) {
        activeCurrency = Int(value)
        currencyLabel.setText(currencies[activeCurrency])
    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        element = elementName
        if attributeDict["name"] != nil {
            nameAttribute = attributeDict["name"] as String
        } else {
            nameAttribute = ""
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        if element == "field" && nameAttribute == "name" {
            for (index, currency) in enumerate(currencies) {
                if string == "USD/"+currency {
                    getCurrency = index
                }
            }
        }
        if element == "field" && nameAttribute == "price" && getCurrency != -1 {
            currencyConversions[getCurrency] = (string as NSString).doubleValue
            getCurrency = -1
        }
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        currencyLabel.setText("\(currencies[activeCurrency])")
        
        let url = NSURL(string: "http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                var xmlParser = NSXMLParser()
                xmlParser = NSXMLParser(data: data)
                xmlParser.delegate = self
                xmlParser.parse()
            } else {
                NSLog("ERROR")
            }
        })
        task.resume()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
