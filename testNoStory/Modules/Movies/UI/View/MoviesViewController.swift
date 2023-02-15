//
//  MoviesViewController.swift
//  testNoStory
//
//  Created by Andres Valerio on 13/02/23.
//  

import UIKit

protocol MoviesViewControllerProtocol: AnyObject {
    func updateView()
}

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.backgroundColor = Style.colorSystem.neutral.black
        }
    }
    @IBOutlet weak var segmentedControl: UISegmentedControl!{
        didSet{
            segmentedControl.setTitle(Constants.SegmentedTitles.moviesOption[0], forSegmentAt: 0)
            segmentedControl.setTitle(Constants.SegmentedTitles.moviesOption[1], forSegmentAt: 1)
            segmentedControl.setTitle(Constants.SegmentedTitles.moviesOption[2], forSegmentAt: 2)
            segmentedControl.setTitle(Constants.SegmentedTitles.moviesOption[3], forSegmentAt: 3)
            segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
            segmentedControl.backgroundColor = Style.colorSystem.neutral.black
            segmentedControl.tintColor = Style.colorSystem.neutral.gray7
            segmentedControl.setTitleTextAttributes([.foregroundColor: Style.colorSystem.neutral.gray2], for: .normal)
        }
    }
    private let presenter: MoviesPresenterProtocol
    let identifier = String(describing: MovieCell.self)
    var items: [Movie] = []
    init(presenter: MoviesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: MoviesViewController.self), bundle: Bundle.main)
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
        self.view.backgroundColor = Style.colorSystem.neutral.black
        quitBack()
        configureTitleWithRightButtonItem(title: Constants.Titles.movies, color: Style.colorSystem.primary.green0, aligment: .center, font: 20.0, icon: Style.iconCatalog.menu, action: #selector(openMenu))
        let nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        collectionView.register(nibCell, forCellWithReuseIdentifier: identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        presenter.prepareForGetMovieList(type: 0)
        quitBack()
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!){
        presenter.prepareForGetMovieList(type: sender.selectedSegmentIndex)
    }
    
    @objc func openMenu(){
        
    }
}

extension MoviesViewController: MoviesViewControllerProtocol {
    func updateView() {
        items = presenter.movies
        collectionView.reloadData()
    }
}

extension MoviesViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MovieCell else { return UICollectionViewCell() }
        cell.configureCell(movie: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.prepareForMovieDetail(movie: items[indexPath.row])
    }
}

extension MoviesViewController : UICollectionViewDelegateFlowLayout{
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
