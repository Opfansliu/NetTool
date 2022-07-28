//
//  ViewController.swift
//  DebugTools
//
//  Created by 璐 on 2022/7/21.
//

import UIKit
import LLNetTool



class ViewController: UIViewController {
    
    let toolView: UILabel = {
        let toolV = UILabel()
        toolV.text = "Tool"
        toolV.textColor = UIColor.black
        toolV.backgroundColor = UIColor.lightGray
        toolV.isUserInteractionEnabled = true
        toolV.textAlignment = .center
        return toolV
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton()
        btn.setTitle("跳转到下一个页面", for: .normal)
        btn.backgroundColor = UIColor.green
        btn.addTarget(self, action: #selector(pushClick), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.view.backgroundColor = UIColor.white
//        let size = UIScreen.main.bounds.size
//        toolView.frame = CGRect(x: size.width - 100, y: size.height - 200, width: 60, height: 60)
//        toolView.layer.cornerRadius = 30
//        toolView.clipsToBounds = true
//
//
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureClick(_ :)))
//        toolView.addGestureRecognizer(panGesture)
//
//        keyWindow?.makeKeyAndVisible()
////        keyWindow?.addSubview(toolView)
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureClick))
//        toolView.addGestureRecognizer(tapGesture)
//
        view.addSubview(btn)
        btn.frame = CGRect(x: 100, y: 100, width: 160, height: 50);
        
       
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

extension ViewController {
    @objc func tapGestureClick() {
//        if isCurrentViewControllerVisible(clzz: NetTableVC.classForCoder()) {
//            return
//        }
//        let nextTableV = NetTableVC()
//        self.present(nextTableV, animated: true);
//        self.navigationController?.pushViewController(nextTableV, animated: true)
    }
    
    @objc func panGestureClick(_ paramSender: UIPanGestureRecognizer) {
        if paramSender.state != .ended && paramSender.state != .failed {
            let location = paramSender.location(in: paramSender.view?.superview)
            paramSender.view?.center = location
            
        }
        
    }
    @objc func pushClick() {
        LLNetToolHelp.init()
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

