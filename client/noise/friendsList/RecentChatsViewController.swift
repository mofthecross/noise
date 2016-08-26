import UIKit
import RealmSwift

class RecentChatsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    private let cellId = "recentChatCell"
    
    let realm = try! Realm()
    let recentChats = List<Conversation>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Recent"
        collectionView?.alwaysBounceVertical = true
        
    }
}

// UI Congiguration
extension RecentChatsViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recentChats.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 100)
    }
}
    








