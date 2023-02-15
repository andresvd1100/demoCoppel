//
//  MovieDetailViewController.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//  

import UIKit

protocol MovieDetailViewControllerProtocol: AnyObject {
    func updateViewBasic()
    func updateViewCrew()
    
}

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var container: UIView!{
        didSet{
            container.backgroundColor = Style.colorSystem.neutral.transparent
        }
    }
    
    @IBOutlet weak var lblRevenueVal: UILabel!{
        didSet{
            configureLabel(label: lblRevenueVal, withText: "", color: Style.colorSystem.neutral.white, colorBack: Style.colorSystem.neutral.transparent, fontSize: 10.0)
        }
    }
    @IBOutlet weak var lblRevenue: UILabel!{
        didSet{
            configureLabel(label: lblRevenue, withText: Constants.Labels.ingresos, color: Style.colorSystem.neutral.white, colorBack: Style.colorSystem.neutral.transparent, fontSize: 10.0)
        }
    }
    @IBOutlet weak var lblPresVal: UILabel!{
        didSet{
            configureLabel(label: lblPresVal, withText: "", color: Style.colorSystem.neutral.white, colorBack: Style.colorSystem.neutral.transparent, fontSize: 10.0)
        }
    }
    @IBOutlet weak var lblPres: UILabel!{
        didSet{
            configureLabel(label: lblPres, withText: Constants.Labels.budget, color: Style.colorSystem.neutral.white, colorBack: Style.colorSystem.neutral.transparent, fontSize: 10.0)
        }
    }
    @IBOutlet weak var lblStatus: UILabel!{
        didSet{
            configureLabel(label: lblStatus, withText: "", color: Style.colorSystem.neutral.white, colorBack: Style.colorSystem.neutral.transparent, fontSize: 10.0)
        }
    }
    @IBOutlet weak var lblState: UILabel!{
        didSet{
            configureLabel(label: lblState, withText: Constants.Labels.status, color: Style.colorSystem.neutral.white, colorBack: Style.colorSystem.neutral.transparent, fontSize: 10.0)
        }
    }
    @IBOutlet weak var lblDuration: UILabel!{
        didSet{
            configureLabel(label: lblDuration, withText: "", color: Style.colorSystem.primary.green0, colorBack: Style.colorSystem.neutral.transparent, fontSize: 12.0)
        }
    }
    @IBOutlet weak var lblGenres: UILabel!
    {
        didSet{
            configureLabel(label: lblGenres, withText: "", color: Style.colorSystem.primary.green0, colorBack: Style.colorSystem.neutral.transparent, fontSize: 12.0)
        }
    }
    @IBOutlet weak var lblTitle: UILabel!{
        didSet{
            configureLabel(label: lblTitle, withText: "", color: Style.colorSystem.primary.green0, colorBack: Style.colorSystem.neutral.transparent, fontSize: 16.0)
        }
    }
    @IBOutlet weak var imgViewMovie: UIImageView!
    private let presenter: MovieDetailPresenterProtocol
    let cellIdentifier = String(describing: CrewCell.self)
    
    init(presenter: MovieDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: MovieDetailViewController.self), bundle: Bundle.main)
        self.presenter.setViewProtocol(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = Style.colorSystem.primary.blue0
        presenter.prepareFotGetDetailMovie()
        presenter.prepareForGetCrew()
        let nibCell = UINib(nibName: cellIdentifier, bundle: Bundle.main)
        tableView.register(nibCell, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
}

extension MovieDetailViewController: MovieDetailViewControllerProtocol {
    func updateViewBasic() {
        if let url = URL(string: presenter.movie.posterPath ?? "") {
            imgViewMovie.loadImage(url: url, placeholder: UIImage())
        }
        lblTitle.text = presenter.movie.title
        lblDuration.text = "\(Constants.Labels.duration)\(presenter.detailMovie?.duration ?? "")"
        lblGenres.text = "◆ \(presenter.detailMovie?.genres ?? "")"
        lblStatus.text = presenter.detailMovie?.status
        lblPresVal.text = presenter.detailMovie?.budget
        lblRevenueVal.text = presenter.detailMovie?.revenue
        
    }
    func updateViewCrew() {
        tableView.reloadData()
    }
}

extension MovieDetailViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}

extension MovieDetailViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CrewCell else { return UITableViewCell() }
        if(indexPath.section == 0){
            cell.configureCell(items: presenter.cast, title: Constants.Labels.cast)
        }else{
            cell.configureCell(items: presenter.crew, title: Constants.Labels.crew)
        }
        
        return cell
    }
    
    
}
