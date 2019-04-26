import UIKit

class MainTabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tableVC = TableVC()
        let naviTableVC = UINavigationController(rootViewController: tableVC)

        let collectionVC = CollectionVC()
        let naviCollectionVC = UINavigationController(rootViewController: collectionVC)

        tableVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        collectionVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)

        naviTableVC.tabBarItem = UITabBarItem(title: "Table", image: #imageLiteral(resourceName: "List"), selectedImage: nil)
        naviCollectionVC.tabBarItem = UITabBarItem(title: "Collection", image: #imageLiteral(resourceName: "Collection"), selectedImage: nil)
        let controllers = [naviTableVC, naviCollectionVC]
        self.viewControllers = controllers
    }

}
