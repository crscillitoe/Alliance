//
//  LogHandler.swift
//  alliances
//
//  Created by Bradford Bonanno on 4/12/25.
//

import Logging

struct LogLevelHandler: LogHandler {
    var logLevel: Logger.Level = .debug
    
    var metadata = Logger.Metadata()
    var label: String
    
    init(label: String) {
        self.label = label
    }
    
    func log(level: Logger.Level, message: Logger.Message, metadata: Logger.Metadata?, source: String, file: String, function: String, line: UInt) {
        // This will only log messages at or above the set logLevel
        let prettyMetadata = metadata?.isEmpty ?? true ? "" : " \(metadata!)"
        print("[\(level)] [\(file):\(line)] [\(function)] \(message)\(prettyMetadata)")
    }
    
    subscript(metadataKey metadataKey: String) -> Logger.Metadata.Value? {
        get {
            return metadata[metadataKey]
        }
        set(newValue) {
            metadata[metadataKey] = newValue
        }
    }
}
