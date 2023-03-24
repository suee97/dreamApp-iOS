import UIKit
import Alamofire

class LoginViewController: UIViewController {

    // MARK: - Properties
    private lazy var idField: GreyTextField = {
        let textField = GreyTextField()
        textField.configurePlaceholder("학번 8자리를 입력하세요.")
        textField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var pwField: GreyTextField = {
        let textField = GreyTextField()
        textField.configurePlaceholder("비밀번호를 입력하세요.")
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        return textField
    }()
    
    private lazy var loginButton: ActionButton = {
        let button = ActionButton(title: "로그인")
        button.addTarget(self, action: #selector(onTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    private let idLabel: TitleLabel = TitleLabel("학번")
    private let pwLabel: TitleLabel = TitleLabel("비밀번호")
    
    private let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dream_logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 재설정", for: .normal)
        button.setTitleColor(.text_caption, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 15)
        button.addTarget(self, action: #selector(onTapResetButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.text_caption, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 15)
        button.addTarget(self, action: #selector(onTapSignUpButton), for: .touchUpInside)
        return button
    }()
    
    private let helpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        label.textColor = UIColor(red: 255/255, green: 56/255, blue: 69/255, alpha: 1)
        return label
    }()
    
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureGesture()
    }
    
    
    // MARK: - Helpers
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        let na = customNavBarAppearance()
        self.navigationController?.navigationBar.scrollEdgeAppearance = na
        self.navigationController?.navigationBar.compactAppearance = na
        self.navigationController?.navigationBar.standardAppearance = na
        if #available(iOS 15.0, *) {
            navigationController?.navigationBar.compactScrollEdgeAppearance = na
        }
        
        self.navigationItem.title = "로그인"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        self.loginButton.setActive(false)
        
        view.addSubview(self.idField)
        view.addSubview(self.pwField)
        view.addSubview(self.loginButton)
        view.addSubview(self.idLabel)
        view.addSubview(self.pwLabel)
        view.addSubview(self.logo)
        view.addSubview(self.resetButton)
        view.addSubview(self.signUpButton)
        view.addSubview(self.helpLabel)
        
        self.idField.translatesAutoresizingMaskIntoConstraints = false
        self.pwField.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.idLabel.translatesAutoresizingMaskIntoConstraints = false
        self.pwLabel.translatesAutoresizingMaskIntoConstraints = false
        self.logo.translatesAutoresizingMaskIntoConstraints = false
        self.resetButton.translatesAutoresizingMaskIntoConstraints = false
        self.signUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.helpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 109),
            self.logo.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            self.logo.widthAnchor.constraint(equalToConstant: 140),
            self.logo.heightAnchor.constraint(equalToConstant: 67),
            self.idField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -267),
            self.idField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            self.idField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            self.idField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            self.pwField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -177),
            self.pwField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            self.pwField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            self.pwField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            self.loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -57),
            self.loginButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            self.loginButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            self.loginButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            self.idLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -318),
            self.idLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            self.pwLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -228),
            self.pwLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            self.resetButton.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 11),
            self.resetButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            self.signUpButton.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 11),
            self.signUpButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            self.helpLabel.bottomAnchor.constraint(equalTo: self.idLabel.topAnchor, constant: -24),
            self.helpLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func configureGesture() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: - Selectors
    @objc private func onTapLoginButton() {
        self.loginButton.setLoading(true)
        
//        let url = api_url + "/auth/login"
//        let params = ["studentNo" : idField.text, "password" : pwField.text] as Dictionary
//        let request = AF.request(url,
//                                 method: .post,
//                                 parameters: params,
//                                 encoding: JSONEncoding(options: []),
//                                 headers: nil
//        ).responseJSON { data in
//            print(data)
//        }

        // 딜레이
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.loginButton.setLoading(false)
        }
        
        
        self.helpLabel.text = "로그인에 실패하였습니다. 올바른 정보를 입력해주세요."
    }
    
    @objc private func onTapResetButton() {
        print("reset button clicked")
    }
    
    @objc private func onTapSignUpButton() {
        let vc = PolicyAgreeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTextFieldChanged() {
        if idField.text != "" && pwField.text != "" {
            self.loginButton.setActive(true)
        } else {
            self.loginButton.setActive(false)
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            self.view.frame.origin.y = -keyboardHeight
        }
    }
    
    @objc private func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}
