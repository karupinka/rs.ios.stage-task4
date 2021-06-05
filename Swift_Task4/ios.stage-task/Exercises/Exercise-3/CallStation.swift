import Foundation

final class CallStation {
    var usersArr = Set<User>()
    var callsArr = [Call]()
}

extension CallStation: Station {

    func users() -> [User] {
        return Array(usersArr)
    }
    
    func add(user: User) {
        usersArr.insert(user)
    }
    
    func remove(user: User) {
        usersArr.remove(user)
    }
    
    func execute(action: CallAction) -> CallID? {
        var callID: CallID?
        switch action {
        case let .start(from, to):
            var isUserIn = usersArr.contains(from)
            
            
            if isUserIn {
                var isUserBusy = false
                if  usersArr.contains(to) {
                    for call in callsArr {
                        if call.incomingUser == to {
                            if call.status == .calling || call.status == .talk {
                                isUserBusy = true
                            }
                        }
                    }
                    if !isUserBusy {
                        let call = Call(id: UUID(), incomingUser: to, outgoingUser: from, status: .calling)
                        callsArr.append(call)
                        callID = call.id
                    } else {
                        let call = Call(id: UUID(), incomingUser: to, outgoingUser: from, status: .ended(reason: .userBusy))
                        callsArr.append(call)
                        callID = call.id
                    }
                } else {
                    let call = Call(id: UUID(), incomingUser: to, outgoingUser: from, status: .ended(reason: .error))
                    callsArr.append(call)
                    callID = call.id
                }
            }
            

        case let .end(from):
            
            for (index, call) in callsArr.enumerated() {
                if call.incomingUser == from || call.outgoingUser == from {
                    if usersArr.contains(from) {
                    if call.status == .calling {
                        callsArr[index] = Call(id: call.id, incomingUser: call.incomingUser, outgoingUser: call.outgoingUser, status: .ended(reason: .cancel))
                        callID = call.id
                    }
                    else if call.status == .talk {
                        callsArr[index] = Call(id: call.id, incomingUser: call.incomingUser, outgoingUser: call.outgoingUser, status: .ended(reason: .end))
                        callID = call.id
                    }
                    } else {
                        callsArr[index] = Call(id: call.id, incomingUser: call.incomingUser, outgoingUser: call.outgoingUser, status: .ended(reason: .error))
                        callID =  nil
                    }
                }
            }

        case let .answer(from):

            for (index, call) in callsArr.enumerated() {
                if call.incomingUser == from {
                    if call.status == .calling {
                        if usersArr.contains(from) {
                        callsArr[index] = Call(id: call.id, incomingUser: call.incomingUser, outgoingUser: call.outgoingUser, status: .talk)
                        callID = call.id
                        } else {
                            callsArr[index] = Call(id: call.id, incomingUser: call.incomingUser, outgoingUser: call.outgoingUser, status: .ended(reason: .error))
                            callID = nil
                        }
                    }
                }
            }

        default:
            callID = nil
        }

        return callID
    }
    
    func calls() -> [Call] {
        return callsArr
    }
    
    func calls(user: User) -> [Call] {
        var userCallsArr = [Call]()
        for call in callsArr {
            if call.incomingUser == user {
                userCallsArr.append(call)
            }
            else if call.outgoingUser == user {
                userCallsArr.append(call)
            }
        }
        return userCallsArr
    }
    
    func call(id: CallID) -> Call? {
        for call in callsArr {
            if call.id.uuidString == id.uuidString {
                return call
            }
        }
        
        return nil
    }
    
    func currentCall(user: User) -> Call? {
        for call in callsArr {
            if call.incomingUser == user {
                if call.status == .calling {
                    return call
                }
            }
            else if call.outgoingUser == user {
                if call.status == .calling {
                    return call
                }
            }
        }
        
        return nil
    }
}
