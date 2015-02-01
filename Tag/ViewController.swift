//
//  ViewController.swift
//  Tag
//
//  Created by yury on 23.01.15.
//  Copyright (c) 2015 Step. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let buttonInRowCount = 4
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let yCentral: CGFloat = UIScreen.mainScreen().bounds.size.height/2
    var arrayOfAllDigit = [Int]()
    var moves: Int = 0
    var gameField: TGGameModel?
    var lastCellField = TGGameFieldCell()
    
    @IBOutlet weak var winLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var buttonCell = TGGameFieldCell()
        winLabel.text = ""
        
        let sideSize: CGFloat = screenSize.size.width / CGFloat(buttonInRowCount)
        
        arrayOfAllDigit = createArrayWithBaseKey(buttonInRowCount) //real game
        
        //for win test
        //arrayOfAllDigit = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,0,15]
        //var i = 0
        
        let yStart: CGFloat = yCentral - sideSize * CGFloat(buttonInRowCount/2)
        var buttonTitleStr = String()
        var buttonTitleInt: Int!
        var randomIndex: Int
        gameField = TGGameModel(sizeField: buttonInRowCount)

        lastCellField.row = buttonInRowCount - 1
        lastCellField.column = lastCellField.row
        
        
        
        for lineY in 0 ..< buttonInRowCount {
            
            for lineX in 0..<buttonInRowCount {

                randomIndex = Int(randomInt(0, max: (arrayOfAllDigit.count - 1)))
                
                //for real game
                buttonTitleInt = arrayOfAllDigit[randomIndex]
                buttonTitleStr = String(buttonTitleInt)
                arrayOfAllDigit.removeAtIndex(randomIndex)
                
                //for win test
                //buttonTitleInt = arrayOfAllDigit[i]
                //buttonTitleStr = String(buttonTitleInt)
                //i++
                
                
                let button = TGButton()
                button.setTitle(buttonTitleStr, forState: .Normal)
                
                if buttonTitleStr != "0" {
                    button.styleButtonNormal()
                } else {
                    button.styleButtonEmpty()
                }
                
                button.addTarget(self, action: "pressButton:", forControlEvents: UIControlEvents.TouchUpInside)
                
                buttonCell.row = lineX
                buttonCell.column = lineY
                button.cell = buttonCell
                
                button.frame = CGRectMake(
                    CGFloat(CGFloat(lineX) * CGFloat(sideSize)),
                    yStart + sideSize * CGFloat(lineY),
                    sideSize,
                    sideSize)
                
                self.view.addSubview(button)
                
                gameField!.putValue(buttonTitleInt, atIndexGameField: buttonCell)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pressButton(sender:TGButton!) {
        
        var buttonSender: TGButton = sender
        let currentCell: TGGameFieldCell = buttonSender.cell!
        
        var fieldTemp: TGGameFieldCell?
        fieldTemp = gameField?.moveToEmptyPlace(buttonSender.cell!)
        
        if  fieldTemp != nil {
            
            var titleInt = gameField?.valueOfCell(fieldTemp!)
            moves++
            
            for view in self.view.subviews {
                if view.isKindOfClass(TGButton) {
                    var viewButton = view as TGButton
                    
                    if (viewButton.cell?.row == currentCell.row) &&
                       (viewButton.cell?.column == currentCell.column) {
                        viewButton.styleButtonEmpty()
                        viewButton.setTitle("0", forState: .Normal)
                        
                        if (viewButton.cell?.row == lastCellField.row) &&
                            (viewButton.cell?.column == lastCellField.row) {
                                
                                if (gameField?.gameIsWin() == true) {
                                    winLabel.text = "ПОБЕДА за \(moves) шагов"
                                    moves = 0
                                }
                                
                        } else {
                            winLabel.text = ""
                        }
                        
                        
                    } else if (viewButton.cell?.row == fieldTemp!.row) &&
                        (viewButton.cell?.column == fieldTemp!.column) {
                        viewButton.styleButtonNormal()
                        viewButton.setTitle("\(titleInt!)", forState: .Normal)
                    }
                }
            }
        }
    }
    
    func createArrayWithBaseKey(keyInt: Int) -> [Int] {
        var tempArray = [Int] ()
        for i in 0...(keyInt * keyInt) - 1 {
            tempArray.append(i)
        }
        return tempArray
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }

}

