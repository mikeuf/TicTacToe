//
//  GameOpions.swift
//  TicTacToe2
//
//  Created by cyclops on 9/28/18.
//  Copyright © 2018 cyclops. All rights reserved.
//

import Cocoa

class GameOpions: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismissViewController(self);
    }
    
}
