//
//  AppDelegate.swift
//  music_app
//
//  Created by Shaahid on 04/10/21.
//

import UIKit
import CommonCrypto

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

class URLSessionPinningDelegate: NSObject, URLSessionDelegate {
    
    static let publicKeyHash = ["gZAeiDgCNhtlEfjh/KeLXlOLqxoXy+ZHSR0A3shGnhg=", "1OY3vRfq3pv0LyMjTGVunPXC8D9WDGEqYbwI0zFWUcw=", "ppRXq4p594hsUk5XfvAtQ9wAS1dt8J1Qm2BxzHKqwf4="]//latest key => 1OY3vRfq3pv0LyMjTGVunPXC8D9WDGEqYbwI0zFWUcw=
    let rsa2048Asn1Header:[UInt8] = [
        0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
        0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f, 0x00
    ]
    
    
    private func sha256(data : Data) -> String {
        
        var keyWithHeader = Data(rsa2048Asn1Header)
        keyWithHeader.append(data)
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        keyWithHeader.withUnsafeBytes {
        _ = CC_SHA256($0, CC_LONG(keyWithHeader.count), &hash)
        }
        return Data(hash).base64EncodedString()
        
        
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {

        let serverTrust =  challenge.protectionSpace.serverTrust!
        if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
            // Server public key
            var serverPublicKey: SecKey?
            if #available(iOS 12.0, *) {
                serverPublicKey = SecCertificateCopyKey(serverCertificate)
            } else if #available(iOS 10.3, *) {
                serverPublicKey = SecCertificateCopyPublicKey(serverCertificate)
            }
            
            let serverPublicKeyData = SecKeyCopyExternalRepresentation(serverPublicKey!, nil )!
            let data:Data = serverPublicKeyData as Data
            // Server Hash key
            let serverHashKey = sha256(data: data)
            // Local Hash Key
            let publickKeyLocal = type(of: self).publicKeyHash
            if (publickKeyLocal.contains(serverHashKey)) {
                print("Public key pinning is successfully completed")
                completionHandler(.useCredential, URLCredential(trust:serverTrust))
                return
            }
        }
        completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
        return
    }
}
