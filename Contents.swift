//: Playground - noun: a place where people can play

import Cocoa


class ImageArrayUtility {
    var width: Int = 0
    var height: Int = 0
//    var loopIndex: Int = 0
//    var arrayIndex: Int = 0
    var horzOffset: Int = 0
    var vertOffset: Int = 0
    var slope: Int = 0
    var comb: Int = 0
    
    func createEmptyImageArray(width: Int, height: Int) -> [Int] {
        let arraySize = width * height
        return Array(repeating: 0, count: arraySize)
    }
    
    
    func traverseImageArray(array: [Int], rangeMax: Int) -> [Int] {
        var indexArray: [Int] = []
        let calculatedRangeMax = rangeMax / (self.comb + 1)
        for loopIndex in 0...calculatedRangeMax {
            let arrayIndex = self.horzOffset + self.vertOffset + (self.comb * loopIndex * (self.width - self.slope))
            indexArray.append(arrayIndex)
        }
        return indexArray
    }
    
    func createDictionaryToTraverseImageArray(array: [Int], startIndexAt: Int, horzOffset: Int, vertOffset: Int, imageWidth: Int, comb: Int, lineHeight: Int, slope: Int, rangeMax: Int) -> [Int:Int] {
        var indexDictionary: [Int:Int] = [:]
        let calculatedRangeMax = (rangeMax / comb) - 1
        for loopIndex in 0...calculatedRangeMax {
            let key = horzOffset + (vertOffset * imageWidth) + (comb * loopIndex * (lineHeight - slope))
            indexDictionary.updateValue((startIndexAt + loopIndex), forKey: key)
        }
        return indexDictionary
    }
    
    
}

func sortDictByValuesToArrayOfKeys(_ dictionary: [Int:Int]) -> [Int] {
    return Array(dictionary.keys).sorted{dictionary[$0]! < dictionary[$1]!}
}

let imageArrayUtility = ImageArrayUtility()

let newEmptyArray = imageArrayUtility.createEmptyImageArray(width: 10, height: 10)
//print(newEmptyArray)

let comb = 2

let createTopRowRight = imageArrayUtility.createDictionaryToTraverseImageArray(array: newEmptyArray, startIndexAt: 0, horzOffset: 0, vertOffset: 0, imageWidth: 10, comb: comb, lineHeight: 1, slope: 0, rangeMax: 10)
print(sortDictByValuesToArrayOfKeys(createTopRowRight))

let createLastColumnDown = imageArrayUtility.createDictionaryToTraverseImageArray(array: newEmptyArray, startIndexAt: 5, horzOffset: 9, vertOffset: 0, imageWidth: 10, comb: comb, lineHeight: 10, slope: 0, rangeMax: 10)
print(sortDictByValuesToArrayOfKeys(createLastColumnDown))

let createBottomRowLeft = imageArrayUtility.createDictionaryToTraverseImageArray(array: newEmptyArray, startIndexAt: 10,  horzOffset: 0, vertOffset: 9, imageWidth: 10, comb: comb, lineHeight: 1, slope: 0, rangeMax: 10)
print(sortDictByValuesToArrayOfKeys(createBottomRowLeft))

let createFirstColumnUp = imageArrayUtility.createDictionaryToTraverseImageArray(array: newEmptyArray, startIndexAt: 15,  horzOffset: 0, vertOffset: 0, imageWidth: 10, comb: comb, lineHeight: 10, slope: 0, rangeMax: 10)
print(sortDictByValuesToArrayOfKeys(createFirstColumnUp))

let createNegativeDiagonal = imageArrayUtility.createDictionaryToTraverseImageArray(array: newEmptyArray, startIndexAt: 20,  horzOffset: 0, vertOffset: 0, imageWidth: 10, comb: comb, lineHeight: 10, slope: -1, rangeMax: 10)
print(sortDictByValuesToArrayOfKeys(createNegativeDiagonal))

let createPositiveDiagonal = imageArrayUtility.createDictionaryToTraverseImageArray(array: newEmptyArray, startIndexAt: 25,  horzOffset: 9, vertOffset: 0, imageWidth: 10, comb: comb, lineHeight: 10, slope: 1, rangeMax: 10)
print(sortDictByValuesToArrayOfKeys(createPositiveDiagonal))

var createdLookupTable = createTopRowRight
createdLookupTable.merge(createLastColumnDown) { (current, _) in current }
createdLookupTable.merge(createBottomRowLeft) { (current, _) in current }
createdLookupTable.merge(createFirstColumnUp) { (current, _) in current }
createdLookupTable.merge(createNegativeDiagonal) { (current, _) in current }
createdLookupTable.merge(createPositiveDiagonal) { (current, _) in current }

print(sortDictByValuesToArrayOfKeys(createdLookupTable))


let topRow = [0,1,2,3,4,5,6,7,8,9]
let lastColumn = [9,19,29,39,49,59,69,79,89,99]
let negativeDiagonal = [0,11,22,33,44,55,66,77,88,99]



let topRowRightDict = [0:0,1:1,2:2,3:3,4:4,5:5,6:6,7:7,8:8,9:9]
let lastcolumnDownDict = [9:10,19:11,29:12,39:13,49:14,59:15,69:16,79:17,89:18,99:19]
let bottomRowLeftDict = [99:20,88:21,77:22,66:23,55:24,44:25,33:26,22:27,11:28,0:29]
let firstColumnUpDict = [90:30,80:31,70:32,60:33,50:34,40:35,30:36,20:37,10:38,0:39]

var lookuptable = topRowRightDict
//print(lookuptable.count)
lookuptable.merge(lastcolumnDownDict) { (current, _) in current }
//print(lookuptable.count)
lookuptable.merge(bottomRowLeftDict) { (current, _) in current }
//print(lookuptable.count)
lookuptable.merge(firstColumnUpDict) { (current, _) in current }
//print(lookuptable.count)
//print("")
//print(lookuptable)
//print("")
//print(lookuptable.values)
//print("")

var sortedKeys = Array(lookuptable.keys).sorted{lookuptable[$0]! < lookuptable[$1]!}
//print(sortedKeys)







