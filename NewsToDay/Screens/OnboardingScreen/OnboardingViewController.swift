//
//  ViewController.swift
//  news
//
//  Created by Александра Савчук on 05.05.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var onCompletion: (() -> Void)?
    
    private let slides: [Slide] = [
        Slide(image: UIImage(named: "image1"), title: "slidetitle1", description: "slidedescript1"),
        Slide(image: UIImage(named: "image2"), title: "slidetitle2", description: "slidedescript2"),
        Slide(image: UIImage(named: "image3"), title: "slidetitle3", description: "slidedescript3")
    ]
    
    //MARK: - Outlets
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private lazy var nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = UIColor(named: "buttonBlue")
        nextButton.layer.cornerRadius = 8
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        return nextButton
    }()
    
    private var currentIndex = 0 {
        didSet {
            updateUI()
        }
    }
    
    private let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.numberOfPages = 3
        page.currentPage = 0
        page.backgroundStyle = .minimal
        page.pageIndicatorTintColor = .lightGray
        page.currentPageIndicatorTintColor = UIColor(named: "buttonBlue")
        let selectedImage = UIImage(systemName: "rectangle.fill")?.withTintColor(page.currentPageIndicatorTintColor ?? .black, renderingMode: .alwaysTemplate)
        let deselectedImage = UIImage(systemName: "cirle.fill")?.withTintColor(page.pageIndicatorTintColor ?? .lightGray, renderingMode: .alwaysTemplate)
        page.setIndicatorImage(selectedImage, forPage: page.currentPage)
        page.setIndicatorImage(deselectedImage, forPage: page.currentPage + 1)
        page.translatesAutoresizingMaskIntoConstraints = false
        page.isUserInteractionEnabled = true
        return page
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        currentIndex = 0
    }
    
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(pageControl)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(nextButton)
    }
    
    //MARK: - Constraints
    private func setupConstraints() {
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -64),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            nextButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    //MARK: - Functions
    @objc private func updateUI() {
        let slide = slides[currentIndex]
        imageView.image = slide.image
        titleLabel.text = slide.title.localized
        descriptionLabel.text = slide.description.localized
        
        if currentIndex == slides.count - 1 {
            nextButton.setTitle("getStartBtn".localized, for: .normal)
        } else {
            nextButton.setTitle("next".localized, for: .normal)
        }
    }
    
    @objc private func nextButtonTapped() {
        if currentIndex == slides.count - 1 {
            let scene = UIApplication.shared.connectedScenes.first
            if let sceneDelegate = scene?.delegate as? SceneDelegate {
                let vc = UserSignInController()
                sceneDelegate.window?.rootViewController = vc
            }
        } else {
            currentIndex += 1
            updateUI()
            pageControl.currentPage = currentIndex
            pageControl.setIndicatorImage(UIImage(systemName: "rectangle.fill"), forPage: currentIndex)
        }
    }
    
    struct Slide {
        let image: UIImage?
        let title: String
        let description: String
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let currentPage = Int((scrollView.contentOffset.x + width / 2) / width)
        if currentPage != currentIndex {
            currentIndex = currentPage
            updateUI()
            pageControl.currentPage = currentIndex
        }
    }
}
