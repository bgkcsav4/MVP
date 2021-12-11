//
//  Presenter.swift
//  mvp
//
//  Created by Mariam Latsabidze on 11.12.21.
//

import Foundation
import UIKit


protocol UserPresenterDelegate: AnyObject {
    
    func presentUsers(users: [User])
    func presentAlert(title:String, message: String)
}
typealias PresenterDelegate = UserPresenterDelegate & UIViewController
class UserPresenter {
    var delegate : PresenterDelegate?
    
    public func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) {data,_,error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self.delegate?.presentUsers(users: users)
            }
            catch {
                
            }
        }
        task.resume()
    }
    
    public func setViewDelegate(deletage: PresenterDelegate) {
        self.delegate = deletage
    }
    
    
    public func didTapUser(user: User) {
        delegate?.presentAlert(title: user.name, message: "\(user.name) has an email of \(user.name) and username \(user.username)")
    }
    
}
