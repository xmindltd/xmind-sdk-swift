//
//  Template.swift
//  XMindSDK
//
//  Created by h on 2019/11/18.
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

let content_xml = """
<?xml version="1.0" encoding="UTF-8" standalone="no"?><xmap-content xmlns="urn:xmind:xmap:xmlns:content:2.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink" modified-by="bruce" timestamp="1503058545540" version="2.0"><sheet id="7abtd0ssc7n4pi1nu6i7b6lsdh" modified-by="bruce" theme="0kdeemiijde6nuk97e4t0vpp54" timestamp="1503058545540"><topic id="1vr0lcte2og4t2sopiogvdmifc" modified-by="bruce" structure-class="org.xmind.ui.logic.right" timestamp="1503058545417"><title>Warning
警告
Attention
Warnung
경고</title><children><topics type="attached"><topic id="71h1aip2t1o8vvm0a41nausaar" modified-by="bruce" timestamp="1503058545423"><title svg:width="500">This file can not be opened normally, please do not modify and save, otherwise the contents will be permanently lost！</title><children><topics type="attached"><topic id="428akmkh9a0tog6c91qj995qdl" modified-by="bruce" timestamp="1503058545427"><title>You can try using XMind 8 Update 3 or later version to open</title></topic></topics></children></topic><topic id="2kb87f8m38b3hnfhp450c7q35e" modified-by="bruce" timestamp="1503058545434"><title svg:width="500">该文件无法正常打开，请勿修改并保存，否则文件内容将会永久性丢失！</title><children><topics type="attached"><topic id="3m9hoo4a09n53ofl6fohdun99f" modified-by="bruce" timestamp="1503058545438"><title>你可以尝试使用 XMind 8 Update 3 或更新版本打开</title></topic></topics></children></topic><topic id="7r3r4617hvh931ot9obi595r8f" modified-by="bruce" timestamp="1503058545444"><title svg:width="500">該文件無法正常打開，請勿修改並保存，否則文件內容將會永久性丟失！</title><children><topics type="attached"><topic id="691pgka6gmgpgkacaa0h3f1hjb" modified-by="bruce" timestamp="1503058545448"><title>你可以嘗試使用 XMind 8 Update 3 或更新版本打開</title></topic></topics></children></topic><topic id="0f2e3rpkfahg4spg4nda946r0b" modified-by="bruce" timestamp="1503058545453"><title svg:width="500">この文書は正常に開かないので、修正して保存しないようにしてください。そうでないと、書類の内容が永久に失われます。！</title><children><topics type="attached"><topic id="4vuubta53ksc1falk46mevge0t" modified-by="bruce" timestamp="1503058545457"><title>XMind 8 Update 3 や更新版を使って開くこともできます</title></topic></topics></children></topic><topic id="70n9i4u3lb89sq9l1m1bs255j5" modified-by="bruce" timestamp="1503058545463"><title svg:width="500">Datei kann nicht richtig geöffnet werden. Bitte ändern Sie diese Datei nicht und speichern Sie sie, sonst wird die Datei endgültig gelöscht werden.</title><children><topics type="attached"><topic id="1qpc5ee298p2sqeqbinpca46b7" modified-by="bruce" timestamp="1503058545466"><title svg:width="500">Bitte versuchen Sie, diese Datei mit XMind 8 Update 3 oder später zu öffnen.</title></topic></topics></children></topic><topic id="4dmes10uc19pq7enu8sc4bmvif" modified-by="bruce" timestamp="1503058545473"><title svg:width="500">Ce fichier ne peut pas ouvert normalement, veuillez le rédiger et sauvegarder, sinon le fichier sera perdu en permanence. </title><children><topics type="attached"><topic id="5f0rivgubii2launodiln7sdkt" modified-by="bruce" timestamp="1503058545476"><title svg:width="500">Vous pouvez essayer d'ouvrir avec XMind 8 Update 3 ou avec une version plus récente.</title></topic></topics></children></topic><topic id="10pn1os1sgfsnqa8akabom5pej" modified-by="bruce" timestamp="1503058545481"><title svg:width="500">파일을 정상적으로 열 수 없으며, 수정 및 저장하지 마십시오. 그렇지 않으면 파일의 내용이 영구적으로 손실됩니다!</title><children><topics type="attached"><topic id="0l2nr0fq3em22rctapkj46ue58" modified-by="bruce" timestamp="1503058545484"><title svg:width="500">XMind 8 Update 3 또는 이후 버전을 사용하여</title></topic></topics></children></topic></topics></children><extensions><extension provider="org.xmind.ui.map.unbalanced"><content><right-number>-1</right-number></content></extension></extensions></topic><title>Sheet 1</title></sheet></xmap-content>
"""


let theme_snowbrush = """
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

