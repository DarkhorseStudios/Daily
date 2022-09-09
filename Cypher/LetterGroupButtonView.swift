//
//  LetterGroupButtonView.swift
//  Cypher
//
//  Created by Zach Tidwell on 9/1/22.
//

import SwiftUI

struct LetterGroupButtonView: View {
//We'l pass this in as a variable in the active puzzle view
var allLetterGroups: [String]

    var body: some View {
    let rowsOfNames = self.getButtonNamesInRows()
    //Draws buttons in HStacks so they are presented as rows
ForEach(rowsOfNames, id: \.self) { row in
var arrayOfNames = row
HStack {
ForEach(arrayOfNames, id: \.self) { name in
LetterGroupButton(name: name)
}//nested ForEach
}//HStack
}//ForEach
    }//body

//Each row of button names  is tored as an array, with each array of rows being nested inside the main array that is returned
func getButtonNamesInRows() -> [[String]] {
var mainArray = [[String]]()
var allLetterGroupsCopy = allLetterGroups
//Decide how many buttons should be in each row.
let rowCount = calculateRowCount()
let letterGroupsPerRow = Int(allLetterGroupsCopy.count / rowCount)
//Check the modulas of the wordGroups divided by the noumber or rows to see if we'll need an extra row at the end of the loops.
var needExtraRow = false
if allLetterGroupsCopy.count % rowCount != 0 {
needExtraRow = true
}//conditional
//A forEach loop that iterates over each of the button name values, organizing them into rows
for _ in 1...rowCount {
var newArray = [String]()
//Need a nested array that accounts for the count of the copy divided by the number of rows.
for _ in 1...letterGroupsPerRow {
let newGroupIndex = Int.random(in: 0..<allLetterGroupsCopy.count)
newArray.append(allLetterGroupsCopy[newGroupIndex])
allLetterGroupsCopy.remove(at: newGroupIndex)
}//nested loop
mainArray.append(newArray)
}//For loop for rows

//Check if we need an extra row before returning the array
if needExtraRow {
var extraRow = [String]()
for i in 0..<allLetterGroupsCopy.count {
extraRow.append(allLetterGroupsCopy[i])
}//loop for extra row
mainArray.append(extraRow)
}//conditional for extra row

return mainArray
}
func calculateRowCount() -> Int {
//Decide how many buttons should be in each row.
//This may produce a double, so I need to handle this.
let rowCount = (Int(allLetterGroups.count / Int.random(in: 2...5)))
return rowCount
}//func calculateRowCount


}//struct

struct LetterGroupButtonView_Previews: PreviewProvider {
    static var previews: some View {

var previewLetterGroups = ["preview 1", "preview 2", "preview 3"]
        LetterGroupButtonView(allLetterGroups: previewLetterGroups)
    }
}
