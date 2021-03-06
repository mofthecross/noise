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
    
    func signIn(user: Dictionary<String, String>, handleSignIn: (success: Bool) -> Void){
        // TEST: ping socket, display in console
        print("Test: hit signIn func for user: \(user)")
        
        // SEND userData to db
        socket.emit("signIn", user)
        
        socket.on("signIn unsuccessful") { (userArray, socketAck) -> Void in
            print("Unsuccessful userMatch", userArray)
            handleSignIn(success: false)
        }
        
        socket.on("signIn successful") { (userArray, socketAck) -> Void in
            print("Successful userMatch", userArray)
            handleSignIn(success: true)
        }
    }
    
    func signUp(user: Dictionary<String, String>, handleSignUp: (success: Bool) -> Void) {
        //TEST:ping socket, display in console
        print("Test: socket func, addUser: \(user)")
        
        //TODO: if pwText1 matches pwText2
        
        //SEND: userData to db
        socket.emit("userSigningUp", user)
        
        
        //SUCCESS: receive user_sign_in_data back from db
        socket.on("sign up success") { (user) -> Void in
            print("signUP success!!!")
            handleSignUp(success: true)
        }
        
        //FAIL: receive user_sign_UP_data back from db
        socket.on("username taken") { (user) -> Void in
            print("Unsuccessful userMatch", user)
            handleSignUp(success: false)
        }
        socket.on("signUp failure") { (error) -> Void in
            print("Error in db on signUp", error)
        }
    }
    
    // change this to 1) encrypted message 2) noisified message --both dictionaries
    func sendEncryptedChat(message: String){
        print("From socket func, sendChat: \(message)")
        
        //
        socket.emit("encryptedChatSent", message)
    }
    
    // Dictionary<String, String>
    func sendNoisifiedChat(messageDP: String){
        print("TEST: socketMGMT sendingDPChat: \(messageDP)")
        socket.emit("noisifiedChatSent", messageDP)
        
        //listen for successfully added
        socket.on("DP message sent") { (messageDP) -> Void in
            
        }
        
        //listen for fail
    }
    
    func addFriend(newFriend: String){
        print("Test: socket func, addFriend: \(newFriend)")
        socket.emit("friendAdded", newFriend)
          //Query db for existing friend
    }
    
    func closeConnection() {
        socket.disconnect()
    }

}
