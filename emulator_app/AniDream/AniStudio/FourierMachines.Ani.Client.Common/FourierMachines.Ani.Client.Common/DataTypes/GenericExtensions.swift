//
//  GenericExtensions.swift
//  FourierMachunes.Ani.Client.Studio
//
//  Created by Tej Kiran on 01/05/18.
//  Copyright © 2018 FourierMachines. All rights reserved.

import Foundation


extension Array {
  public func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

extension FileManager{
    
    public func createTemporaryDirectory() -> URL? {
        do {
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
        
        try createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        return url
        } catch {
            //catch the error somehow
        }
        return nil
    }
    
    public func clearTmpDirectory() {
        do {
            let tmpDirURL = FileManager.default.temporaryDirectory
            let tmpDirectory = try contentsOfDirectory(atPath: tmpDirURL.path)
            try tmpDirectory.forEach { file in
                let fileUrl = tmpDirURL.appendingPathComponent(file)
                try removeItem(atPath: fileUrl.path)
            }
        } catch {
            //catch the error somehow
        }
    }
}


extension NSDictionary{
    
   public func toString() -> String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)
        }
        catch ( _){
            return ""
        }
    }
}

extension FloatingPoint {
    @inlinable
    func signum( ) -> Self {
        if self < 0 { return -1 }
        if self > 0 { return 1 }
        return 0
    }
}

public extension String {
    var parseJSONString: Any? {
        guard let jdata = self.data(using: String.Encoding.utf8)
            else {
                return nil
                
        }
//        guard let jsonData = data else {
//            return nil
//
//        }
        do
        {
            return try JSONSerialization.jsonObject(with: jdata, options: JSONSerialization.ReadingOptions.mutableContainers)
        }
        catch
        {
            print("Error info: \(error)")
            return nil
        }
    }
    
    func removeSpecialCharsFromString() -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ")
        return String(self.filter {okayChars.contains($0) })
    }
}

public extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}
