//
//  JoinEmailViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/17.
//

import UIKit
import Alamofire

class JoinEmailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "회원가입"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = .none
    }
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorMessage: UILabel!
    
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var codeErrorMessage: UILabel!
    
    var postId: String = ""
    var postEmail: Email?
    var checkEmail: CheckEmail?
    
    func label(){
        
        let title = UILabel()
        title.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        title.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        title.font = UIFont(name: "GmarketSansTTFMedium", size: 30)
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        // Line height: 25 pt
        title.text = "Welcome!"
        
        self.view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.widthAnchor.constraint(equalToConstant: 300).isActive = true
        title.heightAnchor.constraint(equalToConstant: 50).isActive = true
        title.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 38).isActive = true
        title.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        
        let subTitle = UILabel()
        subTitle.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        subTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        subTitle.font = UIFont(name: "GmarketSansTTFLight", size: 15)
        subTitle.numberOfLines = 0
        subTitle.lineBreakMode = .byWordWrapping
        // Line height: 25 pt
        subTitle.text = "양식에 맞추어 회원정보를 입력해주세요."
        
        self.view.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 38).isActive = true
        subTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        
        let email = UILabel()
        email.frame = CGRect(x: 0, y: 0, width: 98.51, height: 41.11)
        email.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        email.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        // Line height: 24.2 pt
        email.text = "이메일"
        
        self.view.addSubview(email)
        email.translatesAutoresizingMaskIntoConstraints = false
        email.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        email.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        
        // Auto layout, variables, and unit scale are not yet supported
        let check = UILabel()
        check.frame = CGRect(x: 0, y: 0, width: 82.22, height: 42.66)
        check.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        check.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        // Line height: 24.2 pt
        check.text = "인증번호"
        
        self.view.addSubview(check)
        check.translatesAutoresizingMaskIntoConstraints = false
        check.widthAnchor.constraint(equalToConstant: 82.22).isActive = true
        check.heightAnchor.constraint(equalToConstant: 42).isActive = true
        check.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        check.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 310).isActive = true
        
    }
    
    // 입력에 따라 이메일 형식 확인
    @IBAction func emailTextFieldEditingChanged(_ sender: Any) {
        
        if let email = emailTextField.text {
            let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let regex = try! NSRegularExpression(pattern: pattern)
            
            let match = regex.firstMatch(in: email, range: NSRange(email.startIndex..., in: email))
            
            if match == nil {
                emailErrorMessage.text = "이메일을 정확히 입력해주세요."
            } else {
                emailErrorMessage.text = " "
            }
        }
    }
    
    @IBAction func sendCode(_ sender: Any) {
        let url = "\(baseURL.baseURLString)/users/mailAuthentication"
        if let emailText = emailTextField.text {
            postEmail = Email(userEmail: emailText)
        }
        
        if let unwrappedEmail = postEmail {
//            print(unwrappedEmail)
            AF.request(url, method: .post, parameters: unwrappedEmail, encoder: JSONParameterEncoder.default)
                .responseString { response in
                    switch response.result {
                    case .success(let verificationCode):
                        print(verificationCode)
//                        self.emailErrorMessage.text = verificationCode
                    case .failure(let error):
                        print(error)
                    }
                }
        }
    }
    
    
    @IBAction func checkEmail(_ sender: Any) {
        let url = "\(baseURL.baseURLString)/users/mailConfirm"
        if let emailText = emailTextField.text, let codeText = codeTextField.text {
            checkEmail = CheckEmail(userEmail: emailText, code: codeText)
        }
        
        
        if let unwrappedCheckEmail = checkEmail {
            print(unwrappedCheckEmail)
            AF.request(url, method: .post, parameters: unwrappedCheckEmail, encoder: JSONParameterEncoder.default)
                .responseString { response in
                    switch response.result {
                    case .success(let verificationCode):
                        self.nextButton()
                        self.codeErrorMessage.isHidden = true
                        print(verificationCode)
                    case .failure(let error):
                        self.codeErrorMessage.text = "인증번호가 일치하지 않습니다."
                        print(error)
                    }
                }
        }
    }
    
    
    func nextButton(){
            let nextButton = UIButton()
            nextButton.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
            nextButton.layer.backgroundColor = UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1).cgColor
            nextButton.layer.cornerRadius = 20
            
            self.view.addSubview(nextButton)
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            nextButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
            nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
            nextButton.addTarget(self, action: #selector(joinInfo1VC), for: .touchUpInside)
            
            
            let naxtText = UILabel()
            naxtText.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
            naxtText.textColor = UIColor.white
            naxtText.font = UIFont(name: "NotoSansKR-Bold", size: 20)
            // Line height: 27.24 pt
            naxtText.textAlignment = .center
            naxtText.text = "다음"
            
            self.view.addSubview(naxtText)
            naxtText.translatesAutoresizingMaskIntoConstraints = false
            naxtText.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor).isActive = true
            naxtText.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
        }
    @objc func joinInfo1VC() {
        guard  let joinInfo1VC = storyboard?.instantiateViewController(withIdentifier: "joinInfo1") as? JoinInfo1ViewController else { return }
        joinInfo1VC.postId = self.emailTextField.text!
        self.navigationController?.pushViewController(joinInfo1VC, animated: true)
    }
    
}
