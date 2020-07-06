/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class PokeViewController: UIViewController {
  
  enum Section {
    case main
  }
  //MARK: - Properties -
  @IBOutlet weak var pokeCollectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Pokemon>!
  let pokemons = PokemonGenerator.shared.generatePokemons()
  //MARK: - View LifeCycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    //Initializing the collectionView
    pokeCollectionView.collectionViewLayout = configureLayout()
    configureDataSource()
  }
  
  //MARK: - CollectionView Configuation -
  func configureLayout() -> UICollectionViewCompositionalLayout {
    
   
    //Smallest item inside the collectionView to be configured.
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.333), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
    
    //This is the configuration of the Group that contains the items you configured above
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.333))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
    
    //This is the section that holds the configuration of the groups defied above. Top most level.
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0)
    
    //Return the Compositional Layout with the section, which holds the groups, which holds the items you just defined.
    return UICollectionViewCompositionalLayout(section: section)
    
  }//End of Configuration
  
  //MARK: - DataSource -
  func configureDataSource(){
    
    dataSource = UICollectionViewDiffableDataSource<Section, Pokemon>(collectionView: self.pokeCollectionView){
      (pokeCollectionView, indexPath, pokemon) -> UICollectionViewCell? in
      guard let cell = self.pokeCollectionView.dequeueReusableCell(withReuseIdentifier: PokeCell.reuseIdentifier, for: indexPath) as? PokeCell else {
        fatalError("Cannot create New Cell")
      }
      cell.pokeLabel.text = pokemon.pokemonName
      cell.pokeImage.image = UIImage(named: "\(pokemon.pokemonID)")  
      return cell
    }
    var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Pokemon>()
      initialSnapshot.appendSections([.main])
    initialSnapshot.appendItems(pokemons)
    dataSource.apply(initialSnapshot, animatingDifferences: false)
  }//End of DataSource
}//End of Class


