//
//  ProductListCell.swift
//  AdidasTest
//
//  Created by Pavle Mijatovic on 21/11/2020.
//

import UIKit

class ProductListCell: UITableViewCell {

    // MARK: - API
    var productListVM: ProductListVM? {
        willSet {
            setUI(productListVM: newValue)
        }
    }

    // MARK: - Properties
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productDescriptionLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    // MARK: Constants
    static let cellIdentifier = "ProductListCell_ID"
    // MARK: Vars
    private var dataTask: URLSessionTask?

    // MARK: - Lifecycle
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        setUI()
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.dataTask?.cancel()
    }

    // MARK: - Helper
    private func setUI(productListVM: ProductListVM?) {
        productNameLbl.text = productListVM?.name
        productDescriptionLbl.text = productListVM?.description
        productPriceLbl.text = productListVM?.price
        
        if let imgUrlString = productListVM?.imgUrl {
            fetchImage(forUrlString: imgUrlString)
        }
    }
    
    private func fetchImage(forUrlString urlString: String) {
        if let imageFromCache = ImageHelper.imageCache.object(forKey: urlString as AnyObject) {
            self.productImg.image = imageFromCache as? UIImage
            return
        }
        
        productImg.image = nil
        productImg.image = UIImage(named: "productPlaceholder")
        
        guard let url = URL(string: urlString) else { return }
        dataTask = self.getImageData(from: url, completion: { (data, response, error) in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    return
                }
                guard let img = UIImage(data: data) else { return }
                
                ImageHelper.imageCache.setObject(img, forKey: urlString as AnyObject)
                self.productImg.image = UIImage(data: data)
            }
        })
        dataTask?.resume()
    }
    
    private func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) -> URLSessionTask {
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: completion)
        dataTask.resume()
        return dataTask
    }
}
