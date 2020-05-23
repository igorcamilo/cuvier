//
//  HTMLParser.swift
//  MastodonKit
//
//  Created by Igor Camilo on 23.05.20.
//

import libxml2
// We need to import UI frameworks because that's where
// NSAttributedString.Key constants are ¯\_(ツ)_/¯
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

private typealias xmlCharPtr = UnsafePointer<xmlChar>

public struct HTMLParser {
    public init () {}
    
    public func parse(string: String) -> NSAttributedString {
        let doc = htmlReadDoc(string, nil, "UTF-8", Int32(HTML_PARSE_NOIMPLIED.rawValue))
        return processNodeAndNext(firstRelevantNode(doc: doc))
    }
}

private extension HTMLParser {
    func firstRelevantNode(doc: htmlDocPtr?) -> xmlNodePtr? {
        guard let root = xmlDocGetRootElement(doc) else { return nil }
        guard let name = root.pointee.name else { return nil }
        guard String(cString: name).lowercased() == "p" else { return root }
        return root.pointee.children
    }

    func processNodeAndNext(_ nodePtr: xmlNodePtr?) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        guard let node = nodePtr?.pointee else { return attributedString }
        attributedString.append(processNode(node))
        attributedString.append(processNodeAndNext(node.next))
        return attributedString
    }

    func processNode(_ node: xmlNode) -> NSAttributedString {
        switch node.type {
        case XML_ELEMENT_NODE:
            return processElement(node: node)
        case XML_TEXT_NODE:
            return processText(node: node)
        default:
            return NSAttributedString()
        }
    }

    func processElement(node: xmlNode) -> NSAttributedString {
        guard let name = node.name else { return NSAttributedString() }
        switch String(cString: name).lowercased() {
        case "a":
            return processAnchor(node: node)
        case "br":
            return NSAttributedString(string: "\u{2028}") // Line break
        case "p":
            return processParagraph(node: node)
        case "span":
            return processSpan(node: node)
        case let element:
            assertionFailure("Unknown element: \(element)")
            return NSAttributedString()
        }
    }

    func processAnchor(node: xmlNode) -> NSAttributedString {
        // Skip the first <p> if it's the root node, to avoid an empty first line
        let attributedString = NSMutableAttributedString(attributedString: processNodeAndNext(node.children))
        let properties = processProperties(node.properties)
        guard let url = URL(string: properties["href", default: ""]) else { return attributedString }
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.link, value: url, range: range)
        return attributedString
    }

    func processParagraph(node: xmlNode) -> NSAttributedString {
        let paragraph = "\u{2029}"
        let attributedString = NSMutableAttributedString(string: paragraph)
        attributedString.append(processNodeAndNext(node.children))
        return attributedString
    }

    func processSpan(node: xmlNode) -> NSAttributedString {
        processNodeAndNext(node.children)
    }

    func processText(node: xmlNode) -> NSAttributedString {
        guard let content = node.content else { return NSAttributedString() }
        return NSAttributedString(string: String(cString: content))
    }

    func processProperties(_ attrPtr: xmlAttrPtr?) -> [String: String] {
        var attributes: [String: String] = [:]
        var currentAttr = attrPtr?.pointee
        while let attr = currentAttr {
            guard let key = attr.name, let value = attr.children?.pointee.content else { continue }
            attributes[String(cString: key)] = String(cString: value)
            currentAttr = attr.next?.pointee
        }
        return attributes
    }
}
