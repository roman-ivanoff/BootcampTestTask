import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { _ in
            if action != nil {
                action!()
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    func toggleActivityIndicator(indicator: UIActivityIndicatorView, isLoading: Bool) {
        isLoading ? indicator.startAnimating() : indicator.stopAnimating()
    }

    func showHiddenViews(_ views: UIView...) {
        for view in views {
            view.isHidden = false
        }
    }

    func hideViews(_ views: UIView...) {
        for view in views {
            view.isHidden = true
        }
    }

}
