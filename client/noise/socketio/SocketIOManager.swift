
import UIKit

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://localhost:4000")!)
    
    
    override init() {
        super.init()
    }
    
    
    func establishConnection() {
        socket.connect()
    }
    /*change this to 1) encrypted message 2) noisified message --both dictionaries*/
    func sendChat(message: String){
        print("From socket func, sendChat: \(message)")
        socket.emit("chatSent", message)
    }
    
    func addFriend(newFriend: String){
        print("Test: socket func, addFriend: \(newFriend)")
        socket.emit("friendAdded", newFriend)
          //Query db for existing friend
    }

    func signIn(user: Dictionary<String, String>){
        print("Test: socket func, addUser: \(user)")
        socket.emit("newUserAdded", user)
            //Query db for userMatch
    }
    
    func signUp(username: Dictionary<String, String>) {
        print("Test: socket func, addUser: \(username)")
        socket.emit("signinOrSignup", username)
            //Query db for existing user.
            //if NO existing user
               //insert into db
    }
    func closeConnection() {
        socket.disconnect()
    }


}
