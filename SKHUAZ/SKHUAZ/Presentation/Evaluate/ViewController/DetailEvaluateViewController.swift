//
//  DetailEvaluateViewController.swift
//  SKHUAZ
//
//  Created by 천성우 on 2023/09/08.
//

import UIKit

import SnapKit
import Then

class DetailEvaluateViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let mainImage = UIImageView()
    private let detailEvaluateView = EvaluateView(frame: .zero, evaluateType: .detailEvalute)
    private let backButton = UIButton()
    private let saveButton = UIButton()
    
    // MARK: - Properties
    
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBQ0NFU1MiLCJhdWQiOiJnandsZHVkMDcxOUBuYXZlci5jb20iLCJpYXQiOjE2OTUzNzE2ODMsImV4cCI6MTY5NTczMTY4M30.eLdAzQAHD4oJF2EkaTGmLdnxGNxG54KVxyGMA4_Ojpa61g2YKi6C6zeyohwlUDvLvsdfbXqEuIwTLf62NgwYag"
    var evaluationId: Int = 0
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        self.hideKeyboardWhenTappedAround()
        addTarget()
//        detailEvaluateView.setDetailEvaluateView(semester: "상세보기기지롱", professor: "상세보보기기", lecture: "천성우", title: "우성천의 승리", evaluate: "이거 100자 제한 해야하는데", firstPoint: 1, secondPoint: 3, thirdPoint: 4, fourtPoint: 5)
        loadDetailEvaluate()
    }
}

extension DetailEvaluateViewController {

    
    // MARK: - UI Components Property
    
    private func setUI() {
        view.backgroundColor = .white
        
        mainImage.do {
            $0.contentMode = .scaleAspectFit
            $0.image = Image.Logo1
        }
        
        backButton.do {
            $0.layer.cornerRadius = 6
            $0.layer.borderColor = UIColor(hex: "#9AC1D1").cgColor
            $0.layer.borderWidth = 1
            $0.backgroundColor = UIColor(hex: "#FFFFFF")
            $0.setTitle("목록", for: .normal)
            $0.setTitleColor(UIColor(hex: "#9AC1D1"), for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 13)
        }
        
        saveButton.do {
            $0.layer.cornerRadius = 6
            $0.layer.borderColor = UIColor(hex: "#FFFFFF").cgColor
            $0.layer.borderWidth = 1
            $0.backgroundColor = UIColor(hex: "#9AC1D1")
            $0.setTitle("삭제", for: .normal)
            $0.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 13)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        view.addSubviews(mainImage, detailEvaluateView, backButton, saveButton)
        
        mainImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
            $0.leading.equalToSuperview().offset(19)
            $0.width.equalTo(168)
            $0.height.equalTo(43)
        }
        
        detailEvaluateView.snp.makeConstraints {
            $0.top.equalTo(mainImage.snp.bottom)
            $0.leading.equalToSuperview()
            $0.height.equalTo(640)
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
        
        backButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(83)
            $0.height.equalTo(39)
        }
    
        saveButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(83)
            $0.height.equalTo(39)
        }
    }
    
    private func setNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Methods
    
    private func addTarget() {
        backButton.addTarget(self, action: #selector(popToEvaluateViewController), for: .touchUpInside)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func popToEvaluateViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}


extension DetailEvaluateViewController {

    private func loadDetailEvaluate() {
        
        EvaluateAPI.shared.getDetailEvaluation(token: UserDefaults.standard.string(forKey: "AuthToken") ?? "", evaluationId: evaluationId) { result in
                 switch result {
                 case .success(let detailEvaluateDTO):
                     print(detailEvaluateDTO?.data.review ?? "No Review")
                     DispatchQueue.main.async {
                               self.detailEvaluateView.setDetailEvaluateView(
                                   semester: detailEvaluateDTO?.data.lecture.semester ?? "No Review",
                                   professor: detailEvaluateDTO?.data.lecture.profName ?? "No Review",
                                   lecture: detailEvaluateDTO?.data.lecture.lecName ?? "No Review",
                                   title: detailEvaluateDTO?.data.title ?? "No Review",
                                   evaluate: detailEvaluateDTO?.data.review ?? "No Review",
                                   firstPoint:  detailEvaluateDTO?.data.task ?? 0,
                                   secondPoint: detailEvaluateDTO?.data.practice ?? 0,
                                   thirdPoint: detailEvaluateDTO?.data.presentation ?? 0,
                                   fourtPoint: detailEvaluateDTO?.data.teamPlay ?? 0
                               )
                           }
                 case .failure(let error):
                     print("Request failed with error: \(error)")
                 }
            }
    }
    
    func loadUI() {
//        detailEvaluateView.setDetailEvaluateView(semester: "상세보기기지롱", professor: "상세보보기기", lecture: "천성우", title: "우성천의 승리", evaluate: "이거 100자 제한 해야하는데", firstPoint: 1, secondPoint: 3, thirdPoint: 4, fourtPoint: 5)
    }
}
