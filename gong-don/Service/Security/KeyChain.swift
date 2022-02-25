//
//  KeyChain.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/24.
//

import Foundation
import Security

struct User: Codable {
    var email: String
    var password: String
}

final class KeyChain {
    static let shared = KeyChain()
    private let service = Bundle.main.bundleIdentifier
    
    // 생성: 키체인 아이템 생성
    func createUser(_ user: User) {
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
    
    // 조회: 키체인 아이템을 조회하고, 성공하면 User 반환
    func readUser() -> User? {
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
              let user = try? JSONDecoder().decode(User.self, from: data) else {
                  return nil
              }
        
        return user
    }
    
    // 수정: 키체인 아이템을 수정하고, 성공하면 true 반환
    func updateUser(_ user: User) -> Bool {
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
    
    // 삭제: 케체인 아이템을 삭제하고, 성공하면 true 반환
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
