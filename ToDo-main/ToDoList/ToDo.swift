//
//  ToDo.swift
//  ToDoList
//
//  Created by Iulia Anisoi on 21.04.2021.
//

import Foundation

struct ToDo: Equatable, Codable {
    //id will generate number
    let id = UUID()
    //define variable
    var title: String
    var isComplete: Bool
    var notes: String?
    var latitude : String
    var longitude : String
    var accuracy : String
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
   
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: archiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
    //array data
    static func loadSampleToDos() -> [ToDo] {
        let bird1 = ToDo(title: "長尾縫葉鶯", isComplete: false, notes: "香港動植物公園", latitude: "22.277769", longitude: "114.156417",accuracy: "800")
        let bird2 = ToDo(title: "樹麻雀", isComplete: false, notes: "香港動植物公園", latitude: "22.277769", longitude: "114.156417",accuracy: "800")
        let bird3 = ToDo(title: "亞歷山大鸚鵡", isComplete: false, notes: "香港公園", latitude: "22.277404", longitude: "114.161533",accuracy: "800")
        let bird4 = ToDo(title: "噪鵑", isComplete: false, notes: "香港公園", latitude: "22.277404", longitude: "114.161533",accuracy: "800")
        let bird5 = ToDo(title: "赤紅山椒鳥", isComplete: false, notes: "九龍公園", latitude: "22.300602", longitude: "114.170145",accuracy: "800")
        let bird6 = ToDo(title: "白鶺鴒", isComplete: false, notes: "大埔海濱公園", latitude: "22.428761", longitude: "114.207802",accuracy: "800")
        let bird7 = ToDo(title: "北灰鶲", isComplete: false, notes: "元朗公園", latitude: "22.441773", longitude: "114.018785",accuracy: "800")
        let bird8 = ToDo(title: "黑臉琵鷺", isComplete: false, notes: "香港濕地公園", latitude: "22.468722", longitude: "114.00767",accuracy: "800")
        let bird9 = ToDo(title: "普通翠鳥", isComplete: false, notes: "香港濕地公園", latitude: "22.468722", longitude: "114.00767",accuracy: "800")
        let bird10 = ToDo(title: "蒼背山雀", isComplete: false, notes: "屯門公園", latitude: "22.391617", longitude: "113.973667",accuracy: "800")

        return [bird1, bird2, bird3, bird4, bird5, bird6, bird7, bird8, bird9, bird10]
    }
    
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
}
