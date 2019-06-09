//
//  Message.swift
//  ChatApp
//
//  Created by 潤田中 on 2019/06/09.
//  Copyright © 2019 BCC. All rights reserved.
//

import Foundation
import MessageKit

 //classではなくstruct
struct Message: MessageType {
    
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
  
    
}
