import UIKit

class EventDetailViewController: UIViewController {
    
    // MARK: - Properties
    var event: EventWithImage?
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-Bold", size: 25)
        label.numberOfLines = 2
        label.text = event?.title
        return label
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryPurple
        return view
    }()
    
    private lazy var eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = event?.image
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var applyButton: ActionButton = {
        let button = ActionButton(title: "신청하기")
        if event?.eventStatus == .BEFORE {
            button.setActive(false)
        } else if event?.eventStatus == .END {
            button.setActive(false)
            button.backgroundColor = .text_caption
            button.setTitle("종료된 이벤트", for: .normal)
        }
        button.addTarget(self, action: #selector(onTapApplyButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .backgroundPurple
        
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(divider)
        contentView.addSubview(eventImageView)
        contentView.addSubview(applyButton)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: getRatWidth(20)),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -getRatWidth(20)),
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: getRatHeight(20)),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -getRatHeight(20)),
            titleLabel.widthAnchor.constraint(equalToConstant: getRatWidth(280)),
            titleLabel.heightAnchor.constraint(equalToConstant: getRatHeight(60)),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: getRatHeight(16)),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: getRatWidth(18)),
            divider.heightAnchor.constraint(equalToConstant: getRatHeight(1)),
            divider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: getRatHeight(14)),
            divider.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: getRatWidth(20)),
            divider.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -getRatWidth(20)),
            eventImageView.widthAnchor.constraint(equalToConstant: getRatWidth(280)),
            eventImageView.heightAnchor.constraint(equalToConstant: getRatHeight(316.48)),
            eventImageView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: getRatHeight(23)),
            eventImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            applyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -getRatHeight(10)),
            applyButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: getRatWidth(10)),
            applyButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -getRatWidth(10))
        ])
    }
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        let na = customNavBarAppearance()
        self.navigationController?.navigationBar.scrollEdgeAppearance = na
        self.navigationController?.navigationBar.compactAppearance = na
        self.navigationController?.navigationBar.standardAppearance = na
        if #available(iOS 15.0, *) {
            navigationController?.navigationBar.compactScrollEdgeAppearance = na
        }
        
        self.navigationItem.title = "이벤트 참여"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    
    // MARK: - Selectors
    @objc private func onTapApplyButton() {
        guard let formStr = event?.formLink else { return }
        guard let url = URL(string: formStr),
        UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
    // MARK: - Functions


}