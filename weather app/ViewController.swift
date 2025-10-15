import UIKit

extension UIView {
    var usesAutoLayout: Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

class ViewController: UIViewController {


    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView.usesAutoLayout
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        return view.usesAutoLayout
    }()

    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "São Paulo"
        label.textAlignment = .center
        label.textColor = UIColor(named: "primaryColor")
        return label.usesAutoLayout
    }()
    
    private lazy var tempeatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        label.text = "25 C"
        label.textAlignment = .left
        label.textColor = UIColor(named: "primaryColor")
        return label.usesAutoLayout
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
        
        headerView.addSubview(cityLabel)
        headerView.addSubview(tempeatureLabel)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35 ),
            headerView.heightAnchor.constraint(equalToConstant: 169),
            
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
            cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15 ),
            
            tempeatureLabel.topAnchor.constraint(equalTo: cityLabel.topAnchor, constant: 21),
            tempeatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            
        ])
    }
}
