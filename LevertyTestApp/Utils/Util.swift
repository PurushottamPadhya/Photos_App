//
//  Util.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 31/1/22.
//

import Foundation


func isValid(email: String) -> Bool {
  do {
    let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
    let range = NSRange(location: 0, length: email.count)
    let matches = detector.matches(in: email, options: .anchored, range: range)
    guard matches.count == 1 else { return false }
    return matches[0].url?.scheme == "mailto"
  } catch {
    return false
  }
}

extension String {
  var isValidEmail: Bool {
    isValid(email: self)
  }
}

