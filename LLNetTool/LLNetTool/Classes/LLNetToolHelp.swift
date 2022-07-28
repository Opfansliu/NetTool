//
//  LLNetToolHelp.swift
//  LLNetTool
//
//  Created by 璐 on 2022/7/28.
//

import UIKit



public class LLNetToolHelp: NSObject {
    public override init() {
        super.init()
        self.showTool(show: true)
    }
    
    let toolView: UILabel = {
        let toolV = UILabel()
        toolV.text = "Tool"
        toolV.textColor = UIColor.black
        toolV.backgroundColor = UIColor.lightGray
        toolV.isUserInteractionEnabled = true
        toolV.textAlignment = .center
        return toolV
    }()
    
    public func showTool(show:Bool) {
        if show {
            let size = UIScreen.main.bounds.size
            toolView.frame = CGRect(x: size.width - 100, y: size.height - 200, width: 60, height: 60)
            toolView.layer.cornerRadius = 30
            toolView.clipsToBounds = true
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureClick(_ :)))
            toolView.addGestureRecognizer(panGesture)
            
//            keyWindow?.makeKeyAndVisible()
            getCurrentViewController()?.view?.addSubview(toolView)
//            keyWindow?.addSubview(toolView)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureClick))
            toolView.addGestureRecognizer(tapGesture)
        }
    }

}

var keyWindow: UIWindow? {
    var window: UIWindow? = UIWindow()
    if #available(iOS 13.0, *) {
        for windowScene: UIWindowScene in ((UIApplication.shared.connectedScenes as? Set<UIWindowScene>)!) {
            if windowScene.activationState == .foregroundActive {
                window = windowScene.windows.first
                break
            }
        }
        return UIApplication.shared.delegate?.window ?? window
    } else {
        return UIApplication.shared.keyWindow
    }

}

extension LLNetToolHelp {
    static var current:UIViewController? {
        var vc = UIApplication.shared.keyWindow?.rootViewController

        if (vc?.isKind(of: UITabBarController.self))! {
            vc = (vc as! UITabBarController).selectedViewController
        }else if (vc?.isKind(of: UINavigationController.self))!{
            vc = (vc as! UINavigationController).visibleViewController
        }else if ((vc?.presentedViewController) != nil){
            vc =  vc?.presentedViewController
        }
            
        return vc!
    }
}



extension LLNetToolHelp {
    @objc func tapGestureClick() {
        let nextTableV = NetTableVC()
        LLNetToolHelp.current?.present(nextTableV, animated: true);
//        self.navigationController?.pushViewController(nextTableV, animated: true)
    }
    
    @objc func panGestureClick(_ paramSender: UIPanGestureRecognizer) {
        if paramSender.state != .ended && paramSender.state != .failed {
            let location = paramSender.location(in: paramSender.view?.superview)
            paramSender.view?.center = location
            
        }
        
    }
    @objc func pushClick() {
//        let nextVC = NextViewController()
//        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func isCurrentViewControllerVisible(clzz: AnyClass) -> Bool {
        let vc = getCurrentViewController()
        guard vc != nil else {
            return false
        }
        if ((vc?.isMember(of: clzz)) != nil) {
            return true
        }
        return false
    }
    
    func getCurrentViewController(base: UIViewController? = keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getCurrentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return getCurrentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return getCurrentViewController(base: presented)
        }
        return base
    }
   
}
