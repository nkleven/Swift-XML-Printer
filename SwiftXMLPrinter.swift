import UIKit


class XMLAnalyzer: NSObject, XMLParserDelegate {
    
    var openString = String()
    var closeString = String()
    var indentString = String()
    var tag = String()
    var elementEnded = true
    
    func parserDidStartDocument(_ parser: XMLParser) {
        print("\(Date()):XMLAnalyzer:Starting new document")
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        openString = String()
        if !elementEnded{
            openString = "\n"
        }
        
        elementEnded = false
        
        tag = elementName
    
        indentString = indentString + "\t"
        openString = openString + indentString + "<\(elementName)"
        if attributeDict.count > 0{
            for (key,value) in attributeDict{
                openString = openString + " \(key)=\"\(value)\""
            }
        }
        openString = openString + ">"
        print(openString, terminator: "")
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        elementEnded = true
        
        if tag == elementName{
            closeString = "</\(elementName)>\n"
        }else{
            closeString = indentString + "</\(elementName)>\n"
        }
        let strIndex = indentString.index(indentString.startIndex, offsetBy: 1)
        indentString = indentString.substring(from: strIndex)
        print(closeString, terminator: "")
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print(string, terminator: "")
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("\(Date()):XMLAnalyzer:Done Processing Document")
    }
}
