//
//  ViewController.swift
//  KindleKitExample
//
//  Created by Stoyan Stoyanov on 27/10/2018.
//  Copyright © 2018 Stoyan Stoyanov. All rights reserved.
//

import UIKit
import KindleKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let parsed = try? KindleKit.parse(kindleCSV: csvString) else { return }
        print(parsed)
    }
}

