import UIKit
import RealmSwift


class AddFriendViewController: UIViewController {
    
    @IBOutlet weak var addFriendTextField: UITextField!
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func addFriendTapped(sender: AnyObject) {
        let friendToAdd = addFriendTextField.text
        
        //send friendToAdd to server via socket
            //if friendToAdd is found in redisdb
            let newFriend = Friend(value: [
                "friendUsername" : friendToAdd!,
                "friendFirstname" : "dummy",
                "friendLastname" : "dummy",
                "friendPhoto" : "pic"
                ])
            try! realm.write{
                realm.add(newFriend)
            }
            //display alert: "friends has been added!"
            performSegueWithIdentifier("backToFriendsListSegue", sender: self)
            //else display alert "username not found"

        let friends = realm.objects(Friend)
        print(friends, "added")
        
   }
}
