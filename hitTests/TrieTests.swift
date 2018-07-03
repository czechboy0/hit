//
//  TrieTests.swift
//  LazyReview
//
//  Created by Honza Dvorsky on 08/02/2015.
//  Copyright (c) 2015 Honza Dvorsky. All rights reserved.
//

import UIKit
import XCTest
@testable import hit

class TrieTests: HitTestCase {
    
    func commonWords() -> [String] {
        let strings = ["swiftkey", "swype", "hello", "london", "reality", "fantasy", "stuff"]
        return strings
    }
    
    func testTrieCreation_exactMatches() {
        let strings = self.commonWords()
        let trie = Trie(strings: strings)
        
        let foundStrings = trie.stringsMatchingPrefix("sw")
        XCTAssert(foundStrings.index(of: "swiftkey") != nil, "Couldn't find 'swiftkey' in results")
        XCTAssert(foundStrings.index(of: "swype") != nil, "Couldn't find 'swiftkey' in results")
    }
    
    
    func testCorrectness_inputOutput() {
        let tokens = try! self.prepTokensForTrieTesting()
        let trie = Trie(strings: tokens)
        let resultTokens = trie.exportTrie()
        
        for token in tokens {
            if resultTokens.index(of: token) == nil {
                XCTFail("Didn't return token \(token)")
            }
        }
        //all good
    }
    
    func testPerformance_trieCreation() {
        
        let tokens = try! self.prepTokensForTrieTesting()
        
        self.measure { () -> Void in
            _ = Trie(strings: tokens)
        }
    }
    
    func testPerformance_trieSearch() {
        
        let tokens = try! self.prepTokensForTrieTesting()
        let trie = Trie(strings: tokens)

        self.measure { () -> Void in
            _ = trie.stringsMatchingPrefix("sw")
        }
    }
    
    func testCorrectness_singleCharSearch() {
        let strings = self.commonWords()
        let trie = Trie(strings: strings)
        
        let foundStrings = Set(trie.stringsMatchingPrefix("s"))
        XCTAssertEqual(foundStrings.count, 3)
        XCTAssert(foundStrings.contains("swiftkey"))
        XCTAssert(foundStrings.contains("swype"))
        XCTAssert(foundStrings.contains("stuff"))
    }

    
}
