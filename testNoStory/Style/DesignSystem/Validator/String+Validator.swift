//
//  String+Validator.swift
//  testNoStory
//
//  Created by Andres Valerio on 11/02/23.
//

import Foundation

enum ValidatorType: Int{
    case email = 1
    case name = 2
    case empty = 3
    case none = 4
    case password = 5
    
}

enum ValidationErrors: Error{
    case email
    case empty
    case password
    case none
}

extension ValidationErrors: LocalizedError{
    var errorDescription: String? {
        switch self {
        case .email:
            return Constants.ValidatorMessages.email
        case .empty:
            return Constants.ValidatorMessages.name
       case .password:
            return Constants.ValidatorMessages.password
        case .none:
            return ""
        }
    }
}

extension String{
    
    func validateDataWithType(type: ValidatorType, isMandatory: Bool = true) throws -> Bool{
        if(isMandatory || (!isMandatory && !self.isEmpty)){
            switch type {
                case .email:
                    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                    guard emailPred.evaluate(with: self) == true else {
                        throw ValidationErrors.empty
                        }
                    return emailPred.evaluate(with: self)
                case .name, .empty:
                    guard !self.isEmpty else {
                        throw ValidationErrors.empty
                    }
                    return !self.isEmpty
                
                case .password:
                guard self.trimmingCharacters(in: .whitespaces).count >= 8 else {
                        throw ValidationErrors.password
                    }
                return self.trimmingCharacters(in: .whitespaces).count >= 8
               
                
                case .none:
                    return true
            }
            
        }else{
            return true
        }
    }
    
    
}
