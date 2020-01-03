//
//  PersistenceManager.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 12/31/19.
//  Copyright © 2019 Maksim Khrapov. All rights reserved.
//

// https://www.ultimatepegsolitaire.com/
// https://github.com/mkhrapov/ultimate-peg-solitaire
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


import Foundation


final class PersistenceManager {
    static let shared = PersistenceManager()
    
    
    func save(_ boards: [Board]) {
        do {
            let jsonData: Data = try JSONEncoder().encode(boards)
            let url = getFileURL()
            try jsonData.write(to: url)
        }
        catch EncodingError.invalidValue(let value, let context) {
            print("Encoding Error")
            print("Could not encode value: \(value)")
            print("debugDescription: \(context.debugDescription)")
            fatalError()
        }
        catch {
            print("Unexpected error: \(error).")
            fatalError()
        }
    }
    
    
    func load() -> [Board] {
        do {
            let url = getFileURL()
            let jsonData = try Data(contentsOf: url)
            let boards = try JSONDecoder().decode(Array<Board>.self, from: jsonData)
            return boards
        }
        catch DecodingError.keyNotFound(let key, let context) {
            print("Key Not Found: could not find key \(key) in JSON: \(context.debugDescription)")
            fatalError()
        }
        catch DecodingError.valueNotFound(let type, let context) {
            print("Value not found: \(type) in JSON: \(context.debugDescription)")
            fatalError()
        }
        catch DecodingError.typeMismatch(let type, let context) {
            print("Type mismatch: \(type) in JSON: \(context.debugDescription)")
            fatalError()
        }
        catch DecodingError.dataCorrupted(let context) {
            print("Data currupted in JSON: \(context.debugDescription)")
            fatalError()
        }
        catch {
            print("Unexpected error: \(error).")
            fatalError()
        }
    }
    
    
    private func getFileURL() -> URL {
        do {
            let url: URL = try FileManager.default.url(
                for: .applicationSupportDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            
            return url.appendingPathComponent("list_of_boards").appendingPathExtension("json")
        }
        catch {
            print("Unexpected error: \(error).")
            fatalError()
        }
    }
}
