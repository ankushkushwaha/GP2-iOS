//
//  ViewController.swift
//  Example
//
//  Created by Ankush Kushwaha on 23/07/24.
//  Copyright © 2024 Google Inc. All rights reserved.
//

import Foundation
import UIKit
import AppAuthCore
import AppAuth

//class GP2AuthState {
//     var stateId: String?
//     var accessToken: String?
//     var refreshToken: String?
//     var idToken: String?
//}

class ViewController: UIViewController, OIDAuthStateChangeDelegate {
    private var externalUserAlertSession: OIDExternalUserAgentSession!

    
    func didChange(_ state: OIDAuthState) {
        print(state)
    }
    
    
    private var authState: OIDAuthState?
    private let issuer = URL(string: kIssuer)!
    private let clientID = kClientID
    private let redirectURI = URL(string: kRedirectURI)!
//    private let clientSecret =  // If your client type is confidential
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initiate the authorization flow
        startAuthorization()
    }
    
    func startAuthorization() {
        // Discovering endpoints
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) { configuration, error in
            guard let configuration = configuration else {
                print("Error retrieving discovery document: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            print("Got configuration: \(configuration)")


            guard let redirectURI = URL(string: kRedirectURI) else {
                return
            }
            // Building the request
            let request = OIDAuthorizationRequest(configuration: configuration,
                                                  clientId: kClientID!,
                                                  clientSecret: nil,
                                                  scopes: ["b453a24f-79c5-45a2-b567-da7244a9af4e"
                                                           ,OIDScopeOpenID,
                                                           "offline_access"],
                                                  redirectURL: redirectURI,
                                                  responseType: OIDResponseTypeCode,
                                                  additionalParameters: nil)

            print("Initiating authorization request with scope: \(request.scope ?? "DEFAULT_SCOPE")")

            // Performing the authorization request
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: self) { authState, error in
                if let authState = authState {
                    self.setAuthState(authState)
                    
                    print("Got authorization tokens. Access token: \(authState.lastTokenResponse?.accessToken ?? "nil")")
                } else {
                    print("Authorization error: \(error?.localizedDescription ?? "Unknown error")")
                    self.setAuthState(nil)
                }
            }
        }
    }
    
    @IBAction func logout(_ sender: UIButton) {
        logout {
            print("Logout success")
        }
    }
    
    
    func setAuthState(_ authState: OIDAuthState?) {
        if (self.authState == authState) {
            return;
        }
        
//        let state = GP2AuthState()
//        state.stateId = stateId
//        state.accessToken = authState?.lastTokenResponse?.accessToken
//        state.refreshToken = authState?.lastTokenResponse?.refreshToken
//        state.idToken = authState?.lastTokenResponse?.idToken


        self.authState = authState;
        self.authState?.stateChangeDelegate = self;
        self.stateChanged()
    }
    func stateChanged() {
        self.saveState()
//        self.updateUI()
    }
//    func updateUI() {
//        
//        self.codeExchangeButton.isEnabled = self.authState?.lastAuthorizationResponse.authorizationCode != nil && !((self.authState?.lastTokenResponse) != nil)
//
//    }
    
    func saveState() {

        var data: Data? = nil

        if let authState = self.authState {
            data = NSKeyedArchiver.archivedData(withRootObject: authState)
        }
        
        if let userDefaults = UserDefaults(suiteName: "group.net.openid.appauth.Example") {
            userDefaults.set(data, forKey: kAppAuthExampleAuthStateKey)
            userDefaults.synchronize()
        }
    }

    func loadState() {
        guard let data = UserDefaults(suiteName: "group.net.openid.appauth.Example")?.object(forKey: kAppAuthExampleAuthStateKey) as? Data else {
            return
        }

        if let authState = NSKeyedUnarchiver.unarchiveObject(with: data) as? OIDAuthState {
            self.setAuthState(authState)
        }
    }
    
    public func logout(onSuccess: (() -> Void)? = nil) {

//            guard let userDetailData = UserDefaults.hydraUserDetail else {
//                return
//            }

//            let inksAuthLoginModel = InksAuthLoginModel.fromDictionary(userDetailData)

        let logoutEndpointString = "https://soleranab2bnprd.b2clogin.com/soleranab2bnprd.onmicrosoft.com/b2c_1a_hrdsignin_v2/oauth2/v2.0/logout" + "/?redirect_uri=" + kRedirectURI

        let logoutEndpoint = URL(string: logoutEndpointString)!

        let configuration = OIDServiceConfiguration(authorizationEndpoint: URL(string: "https://soleranab2bnprd.b2clogin.com/soleranab2bnprd.onmicrosoft.com/b2c_1a_hrdsignin_v2/oauth2/v2.0/authorize")!,
                                                    
                                                    tokenEndpoint: URL(string: "https://soleranab2bnprd.b2clogin.com/soleranab2bnprd.onmicrosoft.com/b2c_1a_hrdsignin_v2/oauth2/v2.0/token")!,
                                                    issuer: URL(string: "https://soleranab2bnprd.b2clogin.com/5b68ab67-a8f3-4b79-b5bd-af4c07631e0c/v2.0/")!,
                                                    registrationEndpoint: URL(string: "https://soleranab2bnprd.b2clogin.com/soleranab2bnprd.onmicrosoft.com/b2c_1a_hrdsignin_v2/oauth2/v2.0/logout")!,
                                                    endSessionEndpoint: URL(string: "https://soleranab2bnprd.b2clogin.com/soleranab2bnprd.onmicrosoft.com/b2c_1a_hrdsignin_v2/oauth2/v2.0/logout")!)

        
        
        guard let idToken = authState?.lastTokenResponse?.idToken,
              let state = authState?.lastAuthorizationResponse.state else {
            return
        }
        

        let redirectUrl = URL(string: kRedirectURI)!
        let endSessionRequest = OIDEndSessionRequest(
            configuration: configuration,
            idTokenHint: idToken,
            postLogoutRedirectURL: redirectUrl,
            state: state,
            additionalParameters: nil)
//
        let agent = OIDExternalUserAgentIOS(presenting: self)
//
        self.externalUserAlertSession = OIDAuthorizationService.present(
            endSessionRequest,
            externalUserAgent: agent!) {[weak self] response, error in
                guard let `self` = self else { return }

                if let error = error {
                    print("Authorization error: \(error.localizedDescription)")
                    return
                }

                guard let response = response else {
                    print("Authorization response is nil.")
                    return
                }

                print("Authorization response: \(response)")

                HTTPCookieStorage.shared.cookies?.forEach { cookie in
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                }

                self.setAuthState(nil)

                onSuccess?()
            }
    }
}
