//
//  DetailInterfaceController.swift
//  CurrencyConverterWatchApp
//
//  Created by Rommel Rico on 4/5/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

import WatchKit
import Foundation


class DetailInterfaceController: WKInterfaceController {

    var conversionRate = currencyConversions[activeCurrency]
    
    @IBOutlet weak var dollarAmountLabel: WKInterfaceLabel!
    @IBOutlet weak var convertedAmountLabel: WKInterfaceLabel!
    @IBOutlet weak var currencyLabel: WKInterfaceLabel!
    @IBOutlet weak var amountSlider: WKInterfaceSlider!
    
    @IBAction func doChangeDollarAmount(value: Float) {
        var dollarAmnt = Int(value)
        dollarAmountLabel.setText("\(dollarAmnt) USD =")
        convertedAmountLabel.setText("\( Double(dollarAmnt) * conversionRate)")
        currencyLabel.setText("\(currencies[activeCurrency])")
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        NSLog("Active cr \(conversionRate)")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        dollarAmountLabel.setText("1 USD =")
        convertedAmountLabel.setText("\(currencyConversions[activeCurrency])")
        currencyLabel.setText("\(currencies[activeCurrency])")
        conversionRate = currencyConversions[activeCurrency]
        amountSlider.setValue(1.0)
        NSLog("Active cr wA \(conversionRate)")
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
