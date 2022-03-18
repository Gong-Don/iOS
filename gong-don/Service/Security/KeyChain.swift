//
//  KeyChain.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/24.
//

import Foundation
import Security

struct UserKeyChain: Codable {
    var userId: Int = -1
    var email: String
    var password: String
}

final class KeyChain {
    static let shared = KeyChain()
    private let service = Bundle.main.bundleIdentifier
    
    func createUser(_ user: UserKeyChain) {
        guard let data = try? JSONEncoder().encode(user),
              let service = self.service else { return }
        UserDefaults.standard.setValue(user.email, forKey: "userEmail")
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: user.email,
            kSecAttrGeneric: data
        ]
        
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func readUser() -> UserKeyChain? {
        guard let userEmail = UserDefaults.standard.string(forKey: "userEmail"),
              let service = self.service else { return nil }
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: userEmail,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ]
        
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess {
            return nil
        }
        
        guard let existingItem = item as? [CFString: Any],
              let data = existingItem[kSecAttrGeneric] as? Data,
              let user = try? JSONDecoder().decode(UserKeyChain.self, from: data) else {
                  return nil
              }
        
        return user
    }
    
    func updateUser(_ user: UserKeyChain) -> Bool {
        guard let data = try? JSONEncoder().encode(user),
              let service = self.service,
              let userEmail = UserDefaults.standard.string(forKey: "userEmail") else {
                  return false
              }
        UserDefaults.standard.setValue(user.email, forKey: "userEmail")
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: userEmail
        ]
        
        let attributes: [CFString: Any] = [
            kSecAttrAccount: user.email,
            kSecAttrGeneric: data
        ]
        
        return SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == errSecSuccess
    }
    
    func deleteUser() -> Bool {
        guard let userEmail = UserDefaults.standard.string(forKey: "userEmail"),
              let service = self.service else { return false }
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: userEmail
        ]
        
        UserDefaults.standard.removeObject(forKey: "userEmail")
        return SecItemDelete(query as CFDictionary) == errSecSuccess
    }
}
