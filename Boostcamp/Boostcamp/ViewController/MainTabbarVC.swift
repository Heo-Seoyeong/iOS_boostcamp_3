import UIKit

class MainTabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableVC = TableVC()
        let collectionVC = CollectionVC()

        tableVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        collectionVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)

        tableVC.tabBarItem = UITabBarItem(title: "Table", image: nil, selectedImage: nil)
        collectionVC.tabBarItem = UITabBarItem(title: "Collection", image: nil, selectedImage: nil)
        let controllers = [tableVC, collectionVC]
        self.viewControllers = controllers
    }

}
