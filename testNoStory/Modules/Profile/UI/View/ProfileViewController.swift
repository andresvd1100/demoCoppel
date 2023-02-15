//
//  ProfileViewController.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//  

import UIKit

protocol ProfileViewControllerProtocol: AnyObject {
    func updateView()
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var lblUser: UILabel!{
        didSet{
            configureLabel(label: lblUser, withText: Singleton.shared.email ?? "", color: Style.colorSystem.primary.green0, colorBack: Style.colorSystem.neutral.transparent)
        }
    }
    @IBOutlet weak var btnCloseSession: UIButton!{
        didSet{
            configureButton(button: btnCloseSession, title: Constants.ButtonTitles.closeSession, image: nil, backgroundColor: Style.colorSystem.secondary.information, titleColor: Style.colorSystem.secondary.error)
        }
    }
    @IBOutlet weak var imgUser: UIImageView!{
        didSet{
            imgUser.makeItCircular()
            imgUser.image = Style.iconCatalog.profile
            imgUser.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.backgroundColor = Style.colorSystem.neutral.transparent
        }
    }
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    private let presenter: ProfilePresenterProtocol
    let identifier = String(describing: MovieCell.self)
    var items: [Movie] = []
    
    init(presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: ProfileViewController.self), bundle: Bundle.main)
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
        self.view.backgroundColor = Style.colorSystem.primary.blue0
        let nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        collectionView.register(nibCell, forCellWithReuseIdentifier: identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        presenter.prepareForGetMovies()
    }
}

extension ProfileViewController: ProfileViewControllerProtocol {
    func updateView() {
        collectionView.reloadData()
    }
    
    
}

extension ProfileViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MovieCell else { return UICollectionViewCell() }
        cell.configureCell(movie: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //presenter.prepareForMovieDetail(movie: items[indexPath.row])
    }
}

extension ProfileViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2.1 , height: 250.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
