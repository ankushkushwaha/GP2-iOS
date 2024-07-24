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

class ViewController: UIViewController, OIDAuthStateChangeDelegate {
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
    
    private func setAuthState(_ authState: OIDAuthState?) {
        if (self.authState == authState) {
            return;
        }
        self.authState = authState;
        self.authState?.stateChangeDelegate = self
    }
}
