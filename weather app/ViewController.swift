import UIKit

extension UIView {
    var usesAutoLayout: Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

extension UIColor {
    
    static var primaryColor: UIColor {
        return UIColor(named: "primaryColor") ?? .blue
    }
    
    static var contrastColor: UIColor {
        return UIColor(named: "contrastColor") ?? .white
    }
    
    static var softBlue: UIColor {
        return UIColor(named: "softGray") ?? .lightGray
    }
}

class ViewController: UIViewController {

    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        
        return imageView.usesAutoLayout
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunIcon")
        imageView.contentMode = .scaleAspectFit
        
        return imageView.usesAutoLayout
    }()
    
    private lazy var headerView: UIView = {
        let headerView = UIView()
        headerView.layer.cornerRadius = 20
        headerView.backgroundColor = UIColor.contrastColor
        
        headerView.addSubview(cityLabel)
        headerView.addSubview(tempeatureLabel)
        headerView.addSubview(weatherIcon)
        
        return headerView.usesAutoLayout
    }()

    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "São Paulo"
        label.textAlignment = .center
        label.textColor = UIColor.primaryColor
        return label.usesAutoLayout
    }()
    
    private lazy var tempeatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        label.text = "25 C"
        label.textAlignment = .left
        label.textColor = UIColor.primaryColor
        return label.usesAutoLayout
    }()
    
    private func infosTodayLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        return label.usesAutoLayout
    }
    
    private func buildHorizontalStackView(_ views: [UIView]) ->  UIStackView  {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        return stackView.usesAutoLayout;
    }
    
    private lazy var humidityLabel: UILabel = infosTodayLabel("Umidade")
   
    private lazy var humidityValueLabel: UILabel = infosTodayLabel("100mm")
    
    private lazy var windLabel: UILabel = infosTodayLabel("Vento")
   
    private lazy var windValueLabel: UILabel = infosTodayLabel("10km/h")

    private lazy var statsStackView: UIStackView = {
        let humidityStackView: UIStackView = buildHorizontalStackView([humidityLabel, humidityValueLabel])
        
        let windStackView: UIStackView = buildHorizontalStackView([windLabel, windValueLabel])
        
        let stackView = UIStackView(arrangedSubviews: [humidityStackView, windStackView] )
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.backgroundColor = UIColor.softBlue
        stackView.layer.cornerRadius = 10
        stackView.isLayoutMarginsRelativeArrangement = true;
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        
        return stackView.usesAutoLayout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        setHierarchy()
        setConstraints()
    }

    private func setHierarchy() {
        view.addSubview(backgroundView)
        view.addSubview(headerView)
        view.addSubview(statsStackView)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
                headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
                headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
                headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35 ),
                headerView.heightAnchor.constraint(equalToConstant: 169),
                
                cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
                cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
                cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15 ),
                cityLabel.heightAnchor.constraint(equalToConstant: 20),
                
                tempeatureLabel.topAnchor.constraint(equalTo: cityLabel.topAnchor, constant: 21),
                tempeatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 26),
                tempeatureLabel.heightAnchor.constraint(equalToConstant: 85),
                
                weatherIcon.heightAnchor.constraint(equalToConstant: 86),
                weatherIcon.widthAnchor.constraint(equalToConstant: 86),
                weatherIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -26),
                weatherIcon.centerYAnchor.constraint(equalTo: tempeatureLabel.centerYAnchor),
                weatherIcon.leadingAnchor.constraint(equalTo: tempeatureLabel.trailingAnchor, constant: 15)
            ])
        
        NSLayoutConstraint.activate([
            statsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            statsStackView.widthAnchor.constraint(equalToConstant: 206),
            statsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
