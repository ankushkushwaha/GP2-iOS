//
//  AppAuthExampleViewController.swift
//
//  Copyright (c) 2017 The AppAuth Authors.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//


import AppAuth
import UIKit

typealias PostRegistrationCallback = (_ configuration: OIDServiceConfiguration?, _ registrationResponse: OIDRegistrationResponse?) -> Void

/**
 The OIDC issuer from which the configuration will be discovered.
*/

/*
 
 https://soleranab2bnprd.b2clogin.com/SoleraNAB2BNPrd.onmicrosoft.com/B2C_1A_HRDSIGNIN_V2/v2.0/.well-known/openid-configuration
 
mobilemgrdevuser1@mail.com
Solera2024!
 
 
 User: guestuser@example.com
 Password: GuestPassword1
 
 */


// net.openid.appauthdemo:/oauth2redirect?code=707d253a-3b39-4b29-8ed2-70f0e2357de9&state=0Q4ChT_1ZkUJQNCkFRDkdkZH3UnGEKGMlUdsnX8qo_I

//Printing description of response:
//<OIDAuthorizationResponse: 0x600002149310, authorizationCode: 2afe197d-a896-403c-976e-22840cc0face, state: "s6gNGV0_dX3Zw1A9PHZzppxm537GZT4ORtPptyLiQTU", accessToken: "(null)", accessTokenExpirationDate: (null), tokenType: (null), idToken: "(null)", scope: "(null)", additionalParameters: {
//}, request: <OIDAuthorizationRequest: 0x600002921420, request: https://login.authsamples.com/oauth2/authorize?nonce=rICPIbuDuyzadK9IgZQcuzdR8CDFRLEt4E9jnfzgcnQ&response_type=code&code_challenge_method=S256&scope=openid&code_challenge=sPmtC4GCyDd9_HwSL-tSh6WblyAdOabBcUyuYI-9e-s&redirect_uri=net.openid.appauthdemo:/oauth2redirect&client_id=53osemtot8tp3n3qct5r2hijk3&state=s6gNGV0_dX3Zw1A9PHZzppxm537GZT4ORtPptyLiQTU>>



//let kIssuer: String = "https://cognito-idp.eu-west-2.amazonaws.com/eu-west-2_CuhLeqiE9";
//let kClientID: String? = "53osemtot8tp3n3qct5r2hijk3";
//let kRedirectURI: String = "net.openid.appauthdemo:/oauth2redirect";


let kIssuer: String = "https://soleranab2bnprd.b2clogin.com/SoleraNAB2BNPrd.onmicrosoft.com/B2C_1A_HRDSIGNIN_V2/v2.0";
let kClientID: String? = "b453a24f-79c5-45a2-b567-da7244a9af4e";
let kRedirectURI: String = "net.openid.appauthdemo://oauth2redirect/";




//Printing description of response:
//<OIDAuthorizationResponse: 0x6000021340a0, authorizationCode: eyJraWQiOiJmdk1vbXVYc21RRVgyVXpRcmFrYUpxNTVlS1lma0JjOHFUbWxkUW5iM25VIiwidmVyIjoiMS4wIiwiemlwIjoiRGVmbGF0ZSIsInNlciI6IjEuMCJ9.uCno6bMvWIRPhdKUPigoOzD8IiWDYK5QzpQtjSeER-OHkQPCmGiYJM7fg17GOzHv80q_V37DMF3E6fNw5ULPgWeCDRaRmya1fQ1R4ShMO-F8fLMZ_UboY1QrVrif0E-99TqH3_XRAwrLoZbgvubc2dkkFcAkrqP2fWaIQ7LReAs7Genr5JxilERvT5yxdWg6X-Qwa1lfapeCzzkJAjfVpV8gX8KIJ8r8E_paYQuotOMZ-UBiH-3fdWFA0WLs00P8lGuAd4CXeOMI7J5mWqS47h_FBadKPIUv_bpZnu4eTSv1aYd7JbTm52bEb9fOq-Wva2stlMHzK9tgwQdcnLl2cA.HPBIvxd3ImaTkeUI.OGBCBpx6iU3kUD-rZUn4u6tigEXyXBWeNoltRziro1hyY_rVZSel4HBhdsstbxgcz78gTBRu3pkL6qmdAC9OLYywUgd1tBnqXxit3V54FuKTWX0gFm_LATZ6D8hPV5DSbPiZsBC5RajSPJ-sCtYcB5Lb0HbGgcHvEWO9o93z4ih_6tlVcXnT00ZR90xxY8TopLDTQ8BAJlnz1RY0l8nCyP9LBp0xEthKjxQQV4DGFxp8dI_QQPJV4sayK7re5PVekQ1UTYW9ESdg_MsyAULPZrZriHUN_G1R75yK4PxPUcXLSMalZ7-_ezzkA5VTvH1_apgDrExnsYgb6cdo7AIteq_96mJ6unXfJ4Ow882ccDVYz_xN_x2fX_5J1LSGBgkiLvf42DNQMv5D7XA7bSSVZKpJtPUB6_jM0OL5F8upcbl5ElE36jhySYqeJ-f2VX98BQPZJLEk0P95OdqEJ5E0J4zGFkoN7SglX5WPnDuMX-Mn9UWA1QMeNCFuL6lMwoju2mGbA0knQtiSv7XaQNQXeBjlVP5dL2-DOTo6xZN2D3gnhgp8NBTfcw6aYMRr9n9qsxJIKJS1lfGj-LR516dFuetonzcgGB9kdQ90Fet-Lr6jLLKfPszzraF3-yyDre9CFOe-ADeetjoyzxNls7eVInA7jyOA6i1bBTze1znqdfOcjvdxl2uYU5fZJ2WxIcjVpgyl-h4Ph_NH_9ElR7nFNWbQE3G1qc1Jyzah_5-Bvy8YZalfBmUMQ-RFXrizigOub4naHD6_kcEC3acVo_HZA4Z-ZkFFMGicGwYk1BPXe5BC_dZhLnwT5ycidBdtk6dwU6n654E4Nb-ja6afPeQ9evUdrNWR6Q.7Fx3ugpNRyYHuGUqXae-Vw, state: "6f7eEDcpiBjMvYz781INTWk-xDmhobmSgTVloAm7XHc", accessToken: "(null)", accessTokenExpirationDate: (null), tokenType: (null), idToken: "(null)", scope: "(null)", additionalParameters: {
//}, request: <OIDAuthorizationRequest: 0x600002924310, request: https://soleranab2bnprd.b2clogin.com/soleranab2bnprd.onmicrosoft.com/b2c_1a_hrdsignin_v2/oauth2/v2.0/authorize?nonce=AZYBmaBr858e4CV1eFo6cRDPdZmiruibgsqCTt3qSSU&response_type=code&code_challenge_method=S256&scope=openid&code_challenge=L89dMhetBQdglH8o_ego92SUk_nVINpXjTPycvh4MKo&redirect_uri=net.openid.appauthdemo://oauth2redirect/&client_id=b453a24f-79c5-45a2-b567-da7244a9af4e&state=6f7eEDcpiBjMvYz781INTWk-xDmhobmSgTVloAm7XHc>>



// net.openid.appauthdemo://oauth2redirect/?state=F73gqzwXqMeBwVRqPKj4C3y9MNqJYjWLEaMnLRk1gLk&code=eyJraWQiOiJmdk1vbXVYc21RRVgyVXpRcmFrYUpxNTVlS1lma0JjOHFUbWxkUW5iM25VIiwidmVyIjoiMS4wIiwiemlwIjoiRGVmbGF0ZSIsInNlciI6IjEuMCJ9.vxbI--wYuRAaBDwdgo6uZQGM7GW8fks3I_QlK54yKbRQPdNkyx07ILNL0awp5D_79JBVOW-YmuQx5rkIjfydLjkxqy7WYBB39gtwsKk-J71UywYeUmkOl-jCJDsvOlfl8FxZAYrYsJmyNw3vq9EL_dIE22yztQHdcwWMydHGepMX9nYu9d6Ekurd-ayNNsWRKez3t3QbbYDRwta7tThZxEWYSlu0Opuebnw6bf6kkfWKranEOVHcMszVZWWEmm-bVpfFjkMoarVQJJwRRDRzrlmu2STTyvLLEsOZo5NqxuVzV0g6QG_T0x-sVs0X6OYUgdOXWbIZ69tSiv_71BUYYw.tkO23c_zdGomqlbt.PEvi8nAK26QjTFg7yLcGj0EV23E6ejhG2ryE2kAxcPAGX1GFDK6gUpwhmcjSA7Lw7mcmT22MK3bNgCwZpbkq3QHl7Y1Chy3dFONDni1VjDytnJxsqPDjQZ5OsTQbT5zJH9Ah1Ewqz6F7Z7NYnDow-KXzJDx5EglTjC2C61zwSmuur2PS5IzNvorf0njPRc4dBuIVaAiwCEaw-LF274_pc7FJgiBYjT9kqjCvUWQI8iPC44zO8rOjWEfbRQ3Cjp7_CWbc3Z4adPrLWT-a-q4chMMriTC1zDCuEEkCttU-NTjrso7Vbk981U6skrbJTlI4XDzw6wXhi4EEUJxx0DyS69YKO_o7TYXkc9ibqAZ-9Z4vaG60IAmlyysbqvR_cuwsSt2Mn_z4D_1L1PiH6imy24Aezd0sOmJXlbwhc5fCs780-kOyejmmuko8oAntk8eRCEbf7eFAp3JQ2My9mAToSQEM7TO3mlQQMHeuV8nTGifFB-ZR3_acLk1z7d9EKiV9hW9BgpAOHJlkKbU8dY0tl4c6PHTQ1UIN-DzZAAXVV1g8fEx4qWFvpWQPLS0wP3OIWLj7Jkp8bSFNf1-K_fNLaobpKSzdZf8WHUgY2sJh17FECvDqDRNwBqKCeMXQKCLYFwcQAl-QGWV9fj4r503xN2nMer3EGwhcBj-hwDC_cuQ_NwSXAePhsxt5HxqeFEfH-HsiOoAqnHyV51m1qElXW0-fnNdwvq4jCSrdO8ePh7C1FJ8Lxu_U90vkuU1AMv1Riky_zM4Wp0u9D4d9lznznwn488zbd3JoZ__nGeKAAwflw551ZiMhZz9-90Lftv3ups1q8h5UVOJxXPDWneEz6evll05gSnQGhU-r-A.SrzpMB5sTmV4uWx8AnUR-g


let kAppAuthExampleAuthStateKey: String = "authState";


class AppAuthExampleViewController: UIViewController {

    @IBOutlet private weak var authAutoButton: UIButton!
    @IBOutlet private weak var authManual: UIButton!
    @IBOutlet private weak var codeExchangeButton: UIButton!
    @IBOutlet private weak var userinfoButton: UIButton!
    @IBOutlet private weak var logTextView: UITextView!
    @IBOutlet private weak var trashButton: UIBarButtonItem!

    private var authState: OIDAuthState?
    private var externalUserAlertSession: OIDExternalUserAgentSession!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.validateOAuthConfiguration()

        self.loadState()
        self.updateUI()
    }
}

extension AppAuthExampleViewController {

    func validateOAuthConfiguration() {

        // The example needs to be configured with your own client details.
        // See: https://github.com/openid/AppAuth-iOS/blob/master/Examples/Example-iOS_Swift-Carthage/README.md

        assert(kIssuer != "https://issuer.example.com",
                "Update kIssuer with your own issuer.\n" +
                "Instructions: https://github.com/openid/AppAuth-iOS/blob/master/Examples/Example-iOS_Swift-Carthage/README.md");

        assert(kClientID != "YOUR_CLIENT_ID",
                "Update kClientID with your own client ID.\n" +
                "Instructions: https://github.com/openid/AppAuth-iOS/blob/master/Examples/Example-iOS_Swift-Carthage/README.md");

        assert(kRedirectURI != "com.example.app:/oauth2redirect/example-provider",
                "Update kRedirectURI with your own redirect URI.\n" +
                "Instructions: https://github.com/openid/AppAuth-iOS/blob/master/Examples/Example-iOS_Swift-Carthage/README.md");

        // verifies that the custom URI scheme has been updated in the Info.plist
        guard let urlTypes: [AnyObject] = Bundle.main.object(forInfoDictionaryKey: "CFBundleURLTypes") as? [AnyObject], urlTypes.count > 0 else {
            assertionFailure("No custom URI scheme has been configured for the project.")
            return
        }

        guard let items = urlTypes[0] as? [String: AnyObject],
            let urlSchemes = items["CFBundleURLSchemes"] as? [AnyObject], urlSchemes.count > 0 else {
            assertionFailure("No custom URI scheme has been configured for the project.")
            return
        }

        guard let urlScheme = urlSchemes[0] as? String else {
            assertionFailure("No custom URI scheme has been configured for the project.")
            return
        }

        assert(urlScheme != "com.example.app",
                "Configure the URI scheme in Info.plist (URL Types -> Item 0 -> URL Schemes -> Item 0) " +
                "with the scheme of your redirect URI. Full instructions: " +
                "https://github.com/openid/AppAuth-iOS/blob/master/Examples/Example-iOS_Swift-Carthage/README.md")
    }
    

        public func logout(onSuccess: (() -> Void)? = nil) {


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

            let agent = OIDExternalUserAgentIOS(presenting: self)

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

//MARK: IBActions
extension AppAuthExampleViewController {
    @IBAction func logout(_ sender: UIButton) {
        logout {
            print("Logout success")
        }
    }
    @IBAction func authWithAutoCodeExchange(_ sender: UIButton) {

        guard let issuer = URL(string: kIssuer) else {
            self.logMessage("Error creating URL for : \(kIssuer)")
            return
        }

        self.logMessage("Fetching configuration for issuer: \(issuer)")

        // discovers endpoints
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) { configuration, error in

            guard let config = configuration else {
                self.logMessage("Error retrieving discovery document: \(error?.localizedDescription ?? "DEFAULT_ERROR")")
                self.setAuthState(nil)
                return
            }

            self.logMessage("Got configuration: \(config)")

            if let clientId = kClientID {
                self.doAuthWithAutoCodeExchange(configuration: config, clientID: clientId, clientSecret: nil)
            }
//             else {
//                self.doClientRegistration(configuration: config) { configuration, response in
//
//                    guard let configuration = configuration, let clientID = response?.clientID else {
//                        self.logMessage("Error retrieving configuration OR clientID")
//                        return
//                    }
//
//                    self.doAuthWithAutoCodeExchange(configuration: configuration,
//                                                    clientID: clientID,
//                                                    clientSecret: response?.clientSecret)
//                }
//            }
        }

    }

    @IBAction func authNoCodeExchange(_ sender: UIButton) {
//
//        guard let issuer = URL(string: kIssuer) else {
//            self.logMessage("Error creating URL for : \(kIssuer)")
//            return
//        }
//
//        self.logMessage("Fetching configuration for issuer: \(issuer)")
//
//        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) { configuration, error in
//
//            if let error = error  {
//                self.logMessage("Error retrieving discovery document: \(error.localizedDescription)")
//                return
//            }
//
//            guard let configuration = configuration else {
//                self.logMessage("Error retrieving discovery document. Error & Configuration both are NIL!")
//                return
//            }
//
//            self.logMessage("Got configuration: \(configuration)")
//
//            if let clientId = kClientID {
//
//                self.doAuthWithoutCodeExchange(configuration: configuration, clientID: clientId, clientSecret: nil)
//
//            } else {
//
//                self.doClientRegistration(configuration: configuration) { configuration, response in
//
//                    guard let configuration = configuration, let response = response else {
//                        return
//                    }
//
//                    self.doAuthWithoutCodeExchange(configuration: configuration,
//                                                   clientID: response.clientID,
//                                                   clientSecret: response.clientSecret)
//                }
//            }
//        }
    }

//    @IBAction func codeExchange(_ sender: UIButton) {
//
//        guard let tokenExchangeRequest = self.authState?.lastAuthorizationResponse.tokenExchangeRequest() else {
//            self.logMessage("Error creating authorization code exchange request")
//            return
//        }
//
//        self.logMessage("Performing authorization code exchange with request \(tokenExchangeRequest)")
//
//        OIDAuthorizationService.perform(tokenExchangeRequest) { response, error in
//
//            if let tokenResponse = response {
//                self.logMessage("Received token response with accessToken: \(tokenResponse.accessToken ?? "DEFAULT_TOKEN")")
//            } else {
//                self.logMessage("Token exchange error: \(error?.localizedDescription ?? "DEFAULT_ERROR")")
//            }
//            self.authState?.update(with: response, error: error)
//        }
//    }

    @IBAction func userinfo(_ sender: UIButton) {

        guard let userinfoEndpoint = self.authState?.lastAuthorizationResponse.request.configuration.discoveryDocument?.userinfoEndpoint else {
            self.logMessage("Userinfo endpoint not declared in discovery document")
            return
        }

        self.logMessage("Performing userinfo request")

        let currentAccessToken: String? = self.authState?.lastTokenResponse?.accessToken

        self.authState?.performAction() { (accessToken, idToken, error) in

            if error != nil  {
                self.logMessage("Error fetching fresh tokens: \(error?.localizedDescription ?? "ERROR")")
                return
            }

            guard let accessToken = accessToken else {
                self.logMessage("Error getting accessToken")
                return
            }

            if currentAccessToken != accessToken {
                self.logMessage("Access token was refreshed automatically (\(currentAccessToken ?? "CURRENT_ACCESS_TOKEN") to \(accessToken))")
            } else {
                self.logMessage("Access token was fresh and not updated \(accessToken)")
            }

            var urlRequest = URLRequest(url: userinfoEndpoint)
            urlRequest.allHTTPHeaderFields = ["Authorization":"Bearer \(accessToken)"]

            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in

                DispatchQueue.main.async {
                    
                    guard error == nil else {
                        self.logMessage("HTTP request failed \(error?.localizedDescription ?? "ERROR")")
                        return
                    }

                    guard let response = response as? HTTPURLResponse else {
                        self.logMessage("Non-HTTP response")
                        return
                    }

                    guard let data = data else {
                        self.logMessage("HTTP response data is empty")
                        return
                    }

                    var json: [AnyHashable: Any]?

                    do {
                        json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    } catch {
                        self.logMessage("JSON Serialization Error")
                    }

                    if response.statusCode != 200 {
                        // server replied with an error
                        let responseText: String? = String(data: data, encoding: String.Encoding.utf8)

                        if response.statusCode == 401 {
                            // "401 Unauthorized" generally indicates there is an issue with the authorization
                            // grant. Puts OIDAuthState into an error state.
                            let oauthError = OIDErrorUtilities.resourceServerAuthorizationError(withCode: 0,
                                                                                                errorResponse: json,
                                                                                                underlyingError: error)
                            self.authState?.update(withAuthorizationError: oauthError)
                            self.logMessage("Authorization Error (\(oauthError)). Response: \(responseText ?? "RESPONSE_TEXT")")
                        } else {
                            self.logMessage("HTTP: \(response.statusCode), Response: \(responseText ?? "RESPONSE_TEXT")")
                        }

                        return
                    }

                    if let json = json {
                        self.logMessage("Success: \(json)")
                    }
                }
            }

            task.resume()
        }
    }

    @IBAction func trashClicked(_ sender: UIBarButtonItem) {

        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: UIAlertControllerStyle.actionSheet)

        let clearAuthAction = UIAlertAction(title: "Clear OAuthState", style: .destructive) { (_: UIAlertAction) in
            self.setAuthState(nil)
            self.updateUI()
        }
        alert.addAction(clearAuthAction)
        
        let clearLogs = UIAlertAction(title: "Clear Logs", style: .default) { (_: UIAlertAction) in
            DispatchQueue.main.async {
                self.logTextView.text = ""
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)


        alert.addAction(clearLogs)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)

    }
}

//MARK: AppAuth Methods
extension AppAuthExampleViewController {

//    func doClientRegistration(configuration: OIDServiceConfiguration, callback: @escaping PostRegistrationCallback) {
//
//        guard let redirectURI = URL(string: kRedirectURI) else {
//            self.logMessage("Error creating URL for : \(kRedirectURI)")
//            return
//        }
//
//        let request: OIDRegistrationRequest = OIDRegistrationRequest(configuration: configuration,
//                                                                     redirectURIs: [redirectURI],
//                                                                     responseTypes: nil,
//                                                                     grantTypes: nil,
//                                                                     subjectType: nil,
//                                                                     tokenEndpointAuthMethod: "client_secret_post",
//                                                                     additionalParameters: nil)
//
//        // performs registration request
//        self.logMessage("Initiating registration request")
//
//        OIDAuthorizationService.perform(request) { response, error in
//
//            if let regResponse = response {
//                self.setAuthState(OIDAuthState(registrationResponse: regResponse))
//                self.logMessage("Got registration response: \(regResponse)")
//                callback(configuration, regResponse)
//            } else {
//                self.logMessage("Registration error: \(error?.localizedDescription ?? "DEFAULT_ERROR")")
//                self.setAuthState(nil)
//            }
//        }
//    }

    func doAuthWithAutoCodeExchange(configuration: OIDServiceConfiguration, clientID: String, clientSecret: String?) {

        guard let redirectURI = URL(string: kRedirectURI) else {
            self.logMessage("Error creating URL for : \(kRedirectURI)")
            return
        }

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            self.logMessage("Error accessing AppDelegate")
            return
        }

        // builds authentication request
        let request = OIDAuthorizationRequest(configuration: configuration,
                                              clientId: clientID,
                                              clientSecret: clientSecret,
                                              scopes: ["b453a24f-79c5-45a2-b567-da7244a9af4e"
                                                       ,OIDScopeOpenID,
                                                       "offline_access"],
                                              redirectURL: redirectURI,
                                              responseType: OIDResponseTypeCode,
                                              additionalParameters: nil)

        // performs authentication request
        logMessage("Initiating authorization request with scope: \(request.scope ?? "DEFAULT_SCOPE")")

        appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: self) { authState, error in

            if let authState = authState {
                self.setAuthState(authState)
                self.logMessage("Got authorization tokens. Access token: \(authState.lastTokenResponse?.accessToken ?? "DEFAULT_TOKEN")")
            } else {
                self.logMessage("Authorization error: \(error?.localizedDescription ?? "DEFAULT_ERROR")")
                self.setAuthState(nil)
            }
        }
    }

    func doAuthWithoutCodeExchange(configuration: OIDServiceConfiguration, clientID: String, clientSecret: String?) {

        guard let redirectURI = URL(string: kRedirectURI) else {
            self.logMessage("Error creating URL for : \(kRedirectURI)")
            return
        }

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            self.logMessage("Error accessing AppDelegate")
            return
        }

        // builds authentication request
        let request = OIDAuthorizationRequest(configuration: configuration,
                                              clientId: clientID,
                                              clientSecret: clientSecret,
                                              scopes: [OIDScopeOpenID, OIDScopeProfile],
                                              redirectURL: redirectURI,
                                              responseType: OIDResponseTypeCode,
                                              additionalParameters: nil)

        // performs authentication request
        logMessage("Initiating authorization request with scope: \(request.scope ?? "DEFAULT_SCOPE")")

        appDelegate.currentAuthorizationFlow = OIDAuthorizationService.present(request, presenting: self) { (response, error) in

            if let response = response {
                let authState = OIDAuthState(authorizationResponse: response)
                self.setAuthState(authState)
                self.logMessage("Authorization response with code: \(response.authorizationCode ?? "DEFAULT_CODE")")
                // could just call [self tokenExchange:nil] directly, but will let the user initiate it.
            } else {
                self.logMessage("Authorization error: \(error?.localizedDescription ?? "DEFAULT_ERROR")")
            }
        }
    }
}

//MARK: OIDAuthState Delegate
extension AppAuthExampleViewController: OIDAuthStateChangeDelegate, OIDAuthStateErrorDelegate {

    func didChange(_ state: OIDAuthState) {
        self.stateChanged()
    }

    func authState(_ state: OIDAuthState, didEncounterAuthorizationError error: Error) {
        self.logMessage("Received authorization error: \(error)")
    }
}

//MARK: Helper Methods
extension AppAuthExampleViewController {

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

    func setAuthState(_ authState: OIDAuthState?) {
        if (self.authState == authState) {
            return;
        }
        self.authState = authState;
        self.authState?.stateChangeDelegate = self;
        self.stateChanged()
    }

    func updateUI() {

        self.codeExchangeButton.isEnabled = self.authState?.lastAuthorizationResponse.authorizationCode != nil && !((self.authState?.lastTokenResponse) != nil)

        if let authState = self.authState {
            self.authAutoButton.setTitle("1. Re-Auth", for: .normal)
            self.authManual.setTitle("1(A) Re-Auth", for: .normal)
            self.userinfoButton.isEnabled = authState.isAuthorized ? true : false
        } else {
            self.authAutoButton.setTitle("1. Auto", for: .normal)
            self.authManual.setTitle("1(A) Manual", for: .normal)
            self.userinfoButton.isEnabled = false
        }
    }

    func stateChanged() {
        self.saveState()
        self.updateUI()
    }

    func logMessage(_ message: String?) {

        guard let message = message else {
            return
        }

        print(message);

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss";
        let dateString = dateFormatter.string(from: Date())

        // appends to output log
        DispatchQueue.main.async {
            let logText = "\(self.logTextView.text ?? "")\n\(dateString): \(message)"
            self.logTextView.text = logText
        }
    }
}
