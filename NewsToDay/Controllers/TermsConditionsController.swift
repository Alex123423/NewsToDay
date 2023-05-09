//
//  TermsConditionsController.swift
//  NewsToDay
//
//  Created by Edward Kheladze on 09.05.2023.
//

import UIKit

final class TearmsConditionsController: UIViewController {

    //MARK: - Elements

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Terms & Conditions"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next Bold", size: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label

    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        let rules = Rules()
        label.text = rules.rules
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = .systemFont(ofSize: 22)
        label.textColor = #colorLiteral(red: 0.4862745098, green: 0.5098039216, blue: 0.631372549, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.backBarButtonItem?.isEnabled = true
        setupViews()
        setConstraints()
        title = "Terms & Conditions"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "Avenir Next Bold", size: 20)!
        ]
    }

    //MARK: - Methods

    @objc func buttonPressed(_ sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(scrollView)
        contentView.addSubview(subtitleLabel)
        scrollView.addSubview(contentView)
    }


    //MARK: Constraints

    private func setConstraints() {
        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            subtitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}
