//
//  LoginViewController.swift
//  testNoStory
//
//  Created by Andres Valerio on 10/02/23.
//  

import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    func updateWithError(errorMessage: String)
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var errorMessage: UILabel!{
        didSet{
            configureLabel(label: errorMessage, withText: " ", color: Style.colorSystem.secondary.error, aligment: .center, colorBack: Style.colorSystem.neutral.transparent)
        }
    }
    @IBOutlet weak var btnLogin: UIButton!{
        didSet{
            configureButton(button: btnLogin, title: "Login", image: nil, backgroundColor: Style.colorSystem.neutral.gray3, titleColor: Style.colorSystem.neutral.white)
        }
    }
    @IBOutlet weak var textPassword: UITextField!{
        didSet{
            configureTextField(textField: textPassword, placeholder: "Password", textColor: Style.colorSystem.neutral.gray0, isSecure: true)
        }
    }
    @IBOutlet weak var textUser: UITextField!{
        didSet{
            configureTextField(textField: textUser, placeholder: "Username", textColor: Style.colorSystem.neutral.gray0)
        }
    }
    @IBOutlet weak var imgIcon: UIImageView!{
        didSet{
            imgIcon.image = Style.iconCatalog.icon
        }
    }
    private let presenter: LoginPresenterProtocol
    
    init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: LoginViewController.self), bundle: Bundle.main)
        self.presenter.setViewProtocol(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @IBAction func doLogin(_ sender: Any) {
        guard let user = textUser.text, let pass = textPassword.text else { return }
        if(user.isEmpty || pass.isEmpty){
            errorMessage.text = Constants.ValidatorMessages.loginInvalidEmpty
        }else{
            presenter.prepareForLogin(user: user, password: String(format: "%@", textPassword.text ?? ""))
        }
    }
    
    private func configureView() {
        view.backgroundColor = Style.colorSystem.primary.blue0
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    func updateWithError(errorMessage: String) {
        self.errorMessage.text = errorMessage
    }
}
