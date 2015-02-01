//
//  TGGameModel.swift
//  Tag
//
//  Created by yury on 01.02.15.
//  Copyright (c) 2015 Step. All rights reserved.
//

/*

Класс модели игровых данных

*/

struct TGGameFieldCell {
    var column: Int
    var row: Int
    
    init () {
        column = 0
        row = 0
    }
    
    func about() -> String {
        return "column=\(column), row=\(row)"
    }
}

import Foundation

class TGGameModel {
    
    var sizeField: Int?
    private var gameField = Array <Array <Int>>()
    private var emptyCellField: TGGameFieldCell?
    
    init(sizeField: Int) {
        self.sizeField = sizeField
        var value = 0
        
        for column in 0..<sizeField {
            var columnArray = Array<Int>()
            
            for row in 0..<sizeField {
                columnArray.append(value)
            }
            gameField.append(columnArray)
        }
    }
    
    func moveToEmptyPlace (cellField: TGGameFieldCell) -> TGGameFieldCell? {
        
        if (cellField.row == emptyCellField!.row) && (cellField.column == emptyCellField!.column) {
            //println("ПУСТАЯ")
            return nil
            
        } else if cellField.row == emptyCellField!.row {
            //println("Совпадают row")
            var tempCell = TGGameFieldCell()
            tempCell.row = cellField.row
            var emptyCellForReturn: TGGameFieldCell?
            emptyCellForReturn = emptyCellField!
            
            switch cellField.column {
            case emptyCellField!.column - 1:
                //println("Пустая ниже")
                tempCell.column = emptyCellField!.column - 1
                self.swipeCellValue(emptyCellField!, twoCell: tempCell)
                emptyCellField! = tempCell
                return emptyCellForReturn?
            
            case emptyCellField!.column + 1:
                //println("Пустая выше")
                tempCell.column = emptyCellField!.column + 1
                self.swipeCellValue(emptyCellField!, twoCell: tempCell)
                emptyCellField! = tempCell
                return emptyCellForReturn?
            
            default:
                //println("Рядом никого нет")
                return nil
            }
            
        } else if cellField.column == emptyCellField!.column {
            //println("Совпадают column")
            var tempCell = TGGameFieldCell()
            tempCell.column = cellField.column
            var emptyCellForReturn: TGGameFieldCell?
            emptyCellForReturn = emptyCellField!
            
            switch cellField.row {
            case emptyCellField!.row - 1:
                //println("Пустая правее")
                tempCell.row = emptyCellField!.row - 1
                self.swipeCellValue(emptyCellField!, twoCell: tempCell)
                emptyCellField! = tempCell
                return emptyCellForReturn?
                
            case emptyCellField!.row + 1:
                //println("Пустая левее")
                tempCell.row = emptyCellField!.row + 1
                self.swipeCellValue(emptyCellField!, twoCell: tempCell)
                emptyCellField! = tempCell
                return emptyCellForReturn?
                
            default:
                //println("Рядом НЕТ никого")
                return nil
            }
            
        } else {
            //println("И рядом не стоит")
            return nil
        }
        
    }
    
    private func swipeCellValue (oneCell: TGGameFieldCell, twoCell: TGGameFieldCell) {
        
        let tempValue = self.valueOfCell(oneCell)
        self.putValue(self.valueOfCell(twoCell), atIndexGameField: oneCell)
        self.putValue(tempValue, atIndexGameField: twoCell)
    }
    
    func putValue(value: Int, atIndexGameField: TGGameFieldCell) {
        
        var columnArray = gameField[atIndexGameField.column]
        columnArray[atIndexGameField.row] = value
        gameField[atIndexGameField.column] = columnArray
        
        if value == 0 {
            emptyCellField = atIndexGameField
        }
        
    }
    
    func valueOfCell(atIndexGameField: TGGameFieldCell) -> Int {
        var columnArray = gameField[atIndexGameField.column]
        return columnArray[atIndexGameField.row]
    }
    
    func about() -> String {
        return "self = \(self.gameField)"
    }
    
    func gameIsWin()-> Bool? {

        var i = 1
        var cellValue: Int?
        var tempCell = TGGameFieldCell()
        
        for column in 0..<self.sizeField!  {
            for row in 0..<self.sizeField! {
                
                tempCell.column = column
                tempCell.row = row
                
                cellValue = self.valueOfCell(tempCell)

                if (cellValue == 0) && (i != (self.sizeField! * self.sizeField!)) {
                    return false
                } else if (cellValue != 0) && (cellValue != i) {
                    return false
                }
                i++
            }
        }
        return true
    }
}