//
//  KindleNotesContainer.swift
//  KindleNotes
//
//  Created by Stoyan Stoyanov on 27/10/2018.
//  Copyright © 2018 Stoyan Stoyanov. All rights reserved.
//

import Foundation

// MARK: Public Interface

/// Library that contains all functionality needed to parse a Kindle eReader generated `CSV` file.
public struct KindleKit {
    private init() {}
    
    /// Tries to parse Kindle eReader generated 'CSV' file into a convenient format.
    ///
    /// - Parameter kindleCSV: String that is formatted in the way that Kindle eReader generated csv is when user shares its `Notes` and `Highlights` from a given book.
    /// - Returns: object that contains all data from this csv if it is in valid format.
    /// - Throws: parsing error if string's format is not valid.
    public static func parse(kindleCSV: String) throws -> KindleKit.NotesContainer {
        guard kindleCSV.isValidKindleCSV                  else { throw KindleKit.Error.formatInvalid("csv format is not valid") }
        guard let bookName = kindleCSV.kindleBookName     else { throw KindleKit.Error.formatInvalid("csv format does not contain valid book name") }
        guard let authorName = kindleCSV.kindleBookAuthor else { throw KindleKit.Error.formatInvalid("csv format does not contain valid author name") }
        guard let notes = kindleCSV.kindleBookNotes       else { throw KindleKit.Error.formatInvalid("csv format does not contain valid book notes") }
        
        return KindleKit.NotesContainer(bookName: bookName, bookAuthor: authorName, notes: notes)
    }
}

// MARK: - Note Container

extension KindleKit {
    
    /// Representation of 'CSV' file from a Kindle's eReader's CSV export.
    public struct NotesContainer: CustomStringConvertible {
        
        /// The name of the book as seen on the second line from the CSV file.
        public let bookName: String
        
        /// The name of the author of the book as seen on the third line from the CSV file.
        public let bookAuthor: String
        
        /// All notes contained inside the 'CSV' that this `NotesContainer` represents.
        public let notes: [Note]
        
        
        public var description: String {
            return "<NotesContainer> bookName: '\(bookName)',\n'\(bookAuthor)', '\(notes)'"
        }
    }
}

// MARK: - Note

extension KindleKit {
    
    /// Representation of single `Note` or `Hightlight` from a Kindle's eReader's CSV export.
    public struct Note: CustomStringConvertible {
        
        /// The type of annotation that the user has made (example yellow highlight)
        public let annotationType: String
        
        /// The page on which this note is in the book.
        public let location: String
        
        /// Still not clear what is this.
        public let isStarred: String
        
        /// The main content of this note.
        public let annotation: String
        
        public var description: String {
            return "\n<Note> annotationType: '\(annotationType)', location: '\(location)', isStarred: '\(isStarred)', annotation: '\(annotation)'"
        }
    }
}
