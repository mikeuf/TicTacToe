//
//  ViewController.swift
//  TicTacToe
//
//  A simple Tic-Tac-Toe game to learn the basics of both Swift and Cocoa.
//  The game is only two-player for now.
//
//  Created by Mike Black on 9/27/18.
//  Copyright © 2018 Mike Black. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    //test
    // declare the image buttons for the gameboard
    @IBOutlet weak var cell1: NSButton!
    @IBOutlet weak var cell2: NSButton!
    @IBOutlet weak var cell3: NSButton!
    @IBOutlet weak var cell4: NSButton!
    @IBOutlet weak var cell5: NSButton!
    @IBOutlet weak var cell6: NSButton!
    @IBOutlet weak var cell7: NSButton!
    @IBOutlet weak var cell8: NSButton!
    @IBOutlet weak var cell9: NSButton!
    
    // declare the "Current Player" label under the board
    @IBOutlet weak var labelCurrentPlayer: NSTextField!
    
    // create "cell" array to store state of each cell during game
    enum CurrentPlayer: CustomStringConvertible {
        case x, o, none;
        
        var description: String {
            switch (self) {
            case .x:
                return "X";
            case.o:
                return "O";
            case.none:
                return "none";
            }
        }
    }
    
    // array keeps track of which position is filled by Xs or Os
    var gameBoard = Array(repeating: CurrentPlayer.none, count: 9);
    
    // the patterns that correspond with "three in a row" on a tic tac toe board, assuming that the top-left space is a '0'
    let winConditions: [[Int]] = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]];
    
    // keeps track of whose turn it is (x or o)
    var currentTurn = CurrentPlayer.x;
    
    @IBAction func cell(_ sender: NSButton) {
        // when a cell is clicked
        if (sender.state == .off) {
            /* If the cell is already filled, additional clicks will toggle the button state back to ".off." Since we don't want the user to be able to click the same space more than once, just revert the button state back to ".on"
             and don't make any changes. */
            sender.state = .on;
        } else {
            /* If the cell is not already filled, the state will be toggled to ".on" and we can set the space to the current player. */
            
            /* Since the button tags start at 1, subtract 1 to match the index of the gameBoard array and set the space to either X or O, depending on whose turn it is. */
            gameBoard[sender.tag - 1] = currentTurn;
            
            // if the current player is X
            if (currentTurn == CurrentPlayer.x) {
                // set button image to 'x'
                sender.alternateImage = (#imageLiteral(resourceName: "x-85-103.png"));
            } else {
                // set button image to 'o'
                sender.alternateImage = (#imageLiteral(resourceName: "o-85-98.png"));
            }
            /* if there is a winner (or a draw), end the game, otherwise switch the player and continue */
            if (!checkForWin()) {
                switchPlayer();
            }
        }
    }
    
    func switchPlayer() {
        /* Alternates the player between X and O after each button click */
        if (currentTurn == CurrentPlayer.x) {
            currentTurn = CurrentPlayer.o;
        } else {
            currentTurn = CurrentPlayer.x;
        }
        // update the GUI label with the current player
        labelCurrentPlayer.stringValue = currentTurn.description;
    }
    
    func checkForWin() -> Bool {
        /* compare the current status of the gameboard to the winning
         combinations, which are "three in a row" by the same player. */
    
        for combination in winConditions {
          
            if ((gameBoard[combination[0]] != CurrentPlayer.none)
                && (gameBoard[combination[0]] == gameBoard[combination[1]])
                && (gameBoard[combination[1]] == gameBoard[combination[2]])) {
                
                // pop-up message declaring the winner
                var _ = alertWinner(winner: gameBoard[combination[0]]);
                // start new game
                initializeGame();
                
                return true;
            }
        }
        /* If all of the spaces are filled (there are no "none" spaces) and there is no winner, declare a draw. */
        if (!gameBoard.contains(CurrentPlayer.none)) {
            // pop up message declaring that the game was a draw
            var _ = alertDraw();
            // start new game
            initializeGame();
            
            return true;
        }
        // if false, then there is no winner and no draw (game continues)
        return false;
    }
    /*
    func checkIfArrayIsFull() -> Bool {
        /* Since the array is pre-initialized to a certain length, it is necessary to iterate through it to determine if it has any non-"none" values. */
        for space in gameBoard {
            if space == CurrentPlayer.none {
                return false;
            }
        }
        return true;
    } */
    
    func initializeGame() {
        /* clears all elements out of the array and resets the images and game conditions*/
        switchPlayer()

        // update "Current player" GUI label to reflect current player
        labelCurrentPlayer.stringValue = currentTurn.description;

        // clear the gameboard
        gameBoard.removeAll();
        
        // fill the gameboard with empty spaces
        for _ in 1...9 {
            gameBoard.append(CurrentPlayer.none);
        }
        
        // reset all of the GUI buttons
        for case let button as NSButton in self.view.subviews {
            button.alternateImage = nil;
            button.state = .off;
            }
    }
    
    // when the user clicks the Reset Game button
    @IBAction func resetGame(_ sender: Any) {
        initializeGame();
    }

    // pop up message declaring a winner
    func alertWinner(winner: CurrentPlayer) -> Bool {
        let alert = NSAlert()
        alert.messageText = "Player '\(winner)' wins!"
        alert.informativeText = "Click OK to play again."
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        return alert.runModal() == .alertFirstButtonReturn

    }
    // pop up message declaring a draw
    func alertDraw() -> Bool {
        let alert = NSAlert()
        alert.messageText = "The game is a draw!"
        alert.informativeText = "Click OK to play again."
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        // alert.addButton(withTitle: "Quit")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        labelCurrentPlayer.stringValue = currentTurn.description;
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}

