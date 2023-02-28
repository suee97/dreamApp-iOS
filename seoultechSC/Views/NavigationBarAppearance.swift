import UIKit
import Foundation

@available(iOS 13.0, *)
public func customNavBarAppearance() -> UINavigationBarAppearance {
    let na = UINavigationBarAppearance()
    let ba = UIBarButtonItemAppearance(style: .plain)
    var backButtonImage: UIImage? {
        return UIImage(named: "pencil")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -12, bottom: -5, right: 0))
    }
    
    ba.normal.titleTextAttributes = [.foregroundColor: UIColor.clear, .font: UIFont.systemFont(ofSize: 0)]
    ba.disabled.titleTextAttributes = [.foregroundColor: UIColor.clear, .font: UIFont.systemFont(ofSize: 0)]
    ba.highlighted.titleTextAttributes = [.foregroundColor: UIColor.clear, .font: UIFont.systemFont(ofSize: 0)]
    ba.focused.titleTextAttributes = [.foregroundColor: UIColor.clear, .font: UIFont.systemFont(ofSize: 0)]
    
    na.backgroundColor = .navy
    na.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    na.titleTextAttributes = [.font: UIFont(name: "Pretendard-Bold", size: 16)!, .foregroundColor: UIColor.white]
    na.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
    
    na.backButtonAppearance = ba
    na.buttonAppearance = ba
    na.doneButtonAppearance = ba

    return na
}
