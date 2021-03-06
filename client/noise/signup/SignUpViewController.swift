import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Override username and password events
        usernameTextField.delegate = self;
        passwordTextField.delegate = self;
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true);
        
        // Hide keyboard if user taps outside of the input field
        super.touchesBegan(touches, withEvent:event)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            // Sign Up
            let userName = usernameTextField.text
            let userPassword = passwordTextField.text
            let user: [String: String] = ["username": userName!, "password": userPassword!]
            if userName!.isEmpty {
                displayAlertMessage("All fields are required!")
            } else {
                SocketIOManager.sharedInstance.signUp(user, handleSignUp: handleSignUp)
            }
            //TODO: add to socket call
        }
         return true
    }
    

    @IBAction func registerButtonTapped(sender: AnyObject) {
        let userName = usernameTextField.text
        let userPassword = passwordTextField.text
        let user : [String:String] = ["username": userName!, "password": userPassword!]
        if(userName!.isEmpty){
            displayAlertMessage("All fields are required!")
        } else {
            SocketIOManager.sharedInstance.signUp(user, handleSignUp: handleSignUp)
        }
    }

    func displayAlertMessage(userMessage: String) {
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    func handleSignUp(success: Bool) {
        if success {
            performSegueWithIdentifier("signUpToFriendsListSegue", sender: self)
        } else {
            let alert:UIAlertController = UIAlertController(title: "Ooftah!", message: "Yoosername is already taken!", preferredStyle: UIAlertControllerStyle.Alert)
            let action:UIAlertAction = UIAlertAction(title: "okee", style: UIAlertActionStyle.Default) { (a: UIAlertAction) -> Void in
                print("okee selected")
            }
            alert.addAction(action)
            self.presentViewController(alert, animated:true) { () -> Void in
                print("alert presented")
            }
        }
    }

    @IBAction func logInButtonClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("logInSegue", sender: self)
    }
}
