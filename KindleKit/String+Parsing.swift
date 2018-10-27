//
//  String+Parsing.swift
//  KindleNotes
//
//  Created by Stoyan Stoyanov on 27/10/2018.
//  Copyright © 2018 Stoyan Stoyanov. All rights reserved.
//

import Foundation

// MARK: - String Helpers

extension String {
    
    /// Gives information whether this string conforms to the standard 'csv' format produced by Kindle eBook readers. The check is not definitive.
    var isValidKindleCSV: Bool {
        let lines = components(separatedBy: .newlines)
        guard lines.count >= 7 else { return false }
        guard lines[0].contains("Your Kindle Notes For:")       else { return false }
        guard lines[3].contains("Free Kindle instant preview:") else { return false }
        guard lines[5].contains("----------------------------------------------") else { return false }
        guard lines[6].contains(",,,") else { return false }
        return true
    }
    
    /// Extraction of book name if this string is a valid Kindle eReader generated CSV.
    var kindleBookName: String? {
        let lines = components(separatedBy: .newlines)
        guard lines.count >= 2   else { return nil }
        guard lines[1].count > 5 else { return nil }
        
        let rangeStart = lines[1].index(after: lines[1].startIndex)
        let rangeEnd   = lines[1].index(lines[1].endIndex, offsetBy: -4)
        
        let name = lines[1][rangeStart...rangeEnd]
        return String(name)
    }
    
    /// Extraction of book author name if this string is a valid Kindle eReader generated CSV.
    var kindleBookAuthor: String? {
        let lines = components(separatedBy: .newlines)
        guard lines.count >= 3   else { return nil }
        guard lines[2].count > 8 else { return nil }
        
        let rangeStart = lines[2].index(lines[2].startIndex, offsetBy: 4)
        let rangeEnd   = lines[2].index(lines[2].endIndex,   offsetBy: -4)
        
        let name = lines[2][rangeStart...rangeEnd]
        return String(name)
    }
    
    /// Extraction of book notes if this string is a valid Kindle eReader generated CSV.
    var kindleBookNotes: [KindleKit.Note]? {
        let lines = components(separatedBy: .newlines)
        guard lines.count >= 9 else { return nil }
        let noteLines = lines[8...]
        
        let notes = noteLines.compactMap { (rawNote) -> KindleKit.Note? in
            guard rawNote.count > 2 else { return nil }
            let trimmedNote = rawNote[rawNote.index(rawNote.startIndex, offsetBy: 1)..<rawNote.index(rawNote.endIndex, offsetBy: -1)]
            let seperated = trimmedNote.components(separatedBy: "\",\"")
            
            guard seperated.count == 4 else { return nil }
            let annotationType = seperated[0]
            let location = seperated[1]
            let starred = seperated[2]
            let annotation = seperated[3]
            
            return KindleKit.Note(annotationType: annotationType, location: location, isStarred: starred, annotation: annotation)
        }
        
        return notes
    }
}
