//
//  Theme.swift
//  XMindSDK
//
//  Created by h on 2019/11/13.
//
//  Copyright © 2019 XMind.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

public struct Theme: Codable {
    
    public struct Item: Codable {
        public let styleId: String?
        public let type: String?
        public let properties: [String: String]?
    }
    
    public let id: String
    
    public let importantTopic: Item?
    public let minorTopic: Item?
    public let expiredTopic: Item?
    public let centralTopic: Item?
    public let boundary: Item?
    public let floatingTopic: Item?
    public let subTopic: Item?
    public let mainTopic: Item?
    public let calloutTopic: Item?
    public let summary: Item?
    public let summaryTopic: Item?
    public let relationship: Item?
    public let map: Item?
    public let level3: Item?

}

extension Theme {
    
    static let snowbrush: Theme = {
        return try! JSONDecoder().decode(Theme.self, from: Theme.theme_snowbrush.data(using: .utf8)!)
    }()
    
    private static let theme_snowbrush = """
    {
      "id":"f7f73af7-90f2-4afe-854b-d4a569205111",
      "importantTopic": {
        "type": "topic",
        "properties": {
          "fo:font-weight": "bold",
          "fo:color": "#F04137",
          "svg:fill": "none"
        }
      },
      "minorTopic": {
        "type": "topic",
        "properties": {
          "svg:fill": "none",
          "fo:font-weight": "bold",
          "fo:color": "#06ABD0"
        }
      },
      "expiredTopic": {
        "type": "topic",
        "properties": {
          "fo:font-style": "italic",
          "fo:text-decoration": " line-through"
        }
      },
      "centralTopic": {
        "properties": {
          "fo:color": "#000000",
          "fo:font-family": "Avenir Next",
          "fo:font-weight": "600",
          "fo:font-size": "24pt",
          "fo:font-style": "normal",
          "border-line-width": "0",
          "border-line-color": "#374C75",
          "line-color": "#374C75",
          "line-width": "3pt",
          "svg:fill": "#FFFFFF"
        },
        "styleId": "39687c955b998eedc81008bf3f",
        "type": "topic"
      },
      "boundary": {
        "properties": {
          "fo:font-style": "normal",
          "fo:color": "#FFFFFF",
          "fo:font-family": "Avenir Next",
          "fo:font-weight": "600",
          "fo:font-size": "14pt",
          "svg:fill": "#E9E9E8",
          "line-color": "#5E5E5E",
          "line-pattern": "dot"
        },
        "styleId": "29f9b72a43c95e2d17c1ebd6c8",
        "type": "boundary"
      },
      "floatingTopic": {
        "properties": {
          "svg:fill": "#EBEBEB",
          "shape-class": "org.xmind.topicShape.roundedRect",
          "border-line-width": "0pt",
          "border-line-color": "#374C75",
          "fo:color": "#332F2E",
          "fo:font-family": "Avenir Next",
          "fo:font-size": "14pt",
          "fo:font-weight": "600",
          "fo:font-style": "normal",
          "line-class": "org.xmind.branchConnection.bight",
          "line-color": "#5E5E5E",
          "line-width": "2pt"
        },
        "styleId": "8edb0655eed84223023988f896",
        "type": "topic"
      },
      "subTopic": {
        "type": "topic",
        "properties": {
          "line-class": "org.xmind.branchConnection.bight",
          "line-width": "1pt",
          "fo:font-family": "Avenir Next",
          "fo:font-size": "14pt",
          "fo:color": "#091C34",
          "fo:text-align": "left"
        }
      },
      "mainTopic": {
        "type": "topic",
        "properties": {
          "border-line-width": "2pt",
          "line-class": "org.xmind.branchConnection.bight",
          "line-width": "2pt",
          "svg:fill": "none",
          "shape-class": "org.xmind.topicShape.underline",
          "fo:color": "#091C34",
          "fo:font-size": "16pt",
          "fo:font-family": "Avenir Next",
          "fo:font-weight": "500"
        }
      },
      "calloutTopic": {
        "properties": {
          "fo:font-weight": "600",
          "fo:font-style": "normal",
          "fo:font-size": "14pt",
          "fo:font-family": "Avenir Next",
          "border-line-width": "0",
          "svg:fill": "#5E5E5E",
          "fo:color": "#FFFFFF"
        },
        "styleId": "4379160bdc98a456dd60a8721d",
        "type": "topic"
      },
      "summary": {
        "properties": {
          "shape-class": "org.xmind.summaryShape.square",
          "line-width": "2pt",
          "line-color": "#5E5E5E"
        },
        "styleId": "14394c4b1a5b6b534182699edf",
        "type": "summary"
      },
      "summaryTopic": {
        "properties": {
          "line-class": "org.xmind.branchConnection.bight",
          "line-width": "1pt",
          "line-color": "#5E5E5E",
          "shape-class": "org.xmind.topicShape.roundedRect",
          "svg:fill": "#EBEBEB",
          "fo:color": "#091C34",
          "fo:font-weight": "600",
          "fo:font-style": "normal",
          "fo:font-family": "Avenir Next",
          "fo:font-size": "14pt",
          "border-line-width": "0pt",
          "border-line-color": "#5E5E5E"
        },
        "styleId": "963bfcbd450931f641aef94ec5",
        "type": "topic"
      },
      "relationship": {
        "properties": {
          "line-width": "2pt",
          "line-pattern": "dot",
          "line-color": "#5E5E5E",
          "fo:font-weight": "600",
          "fo:font-style": "normal",
          "fo:color": "#5E5E5E",
          "fo:font-family": "Avenir Next",
          "fo:font-size": "14pt",
          "arrow-begin-class": "org.xmind.arrowShape.attached"
        },
        "styleId": "67596f401d995d448791686b97",
        "type": "relationship"
      },
      "map": {
        "properties": {
          "multi-line-colors": "#F04137 #F8932E #FEC938 #A0C347 #06ABD0 #832A96",
          "line-tapered": "tapered",
          "svg:fill": "#F5F5FA"
        },
        "styleId": "c9c904312f6968e676f4fafd22",
        "type": "map"
      },
      "level3": {
        "type": "topic",
        "properties": {
          "line-class": "org.xmind.branchConnection.bight",
          "line-width": "1pt",
          "border-line-width": "2pt",
          "fo:font-family": "Avenir Next",
          "fo:font-size": "14pt",
          "fo:color": "#091C34",
          "fo:text-align": "left"
        }
      }
    }
    """


}
