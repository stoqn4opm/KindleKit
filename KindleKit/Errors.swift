//
//  Errors.swift
//  KindleNotes
//
//  Created by Stoyan Stoyanov on 27/10/2018.
//  Copyright © 2018 Stoyan Stoyanov. All rights reserved.
//

import Foundation

// MARK: - Errors

extension KindleKit {
    
    /// All Possible errors that can occur during parsing of CSV string from Kidle's CSV format.
    public enum Error: Swift.Error {
        
        /// Occurs when parsing fails. It can contain reason why parsing failed.
        case formatInvalid(String?)
    }
}
