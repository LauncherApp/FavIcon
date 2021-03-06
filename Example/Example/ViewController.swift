//
// FavIcon
// Copyright © 2018 Leon Breedt
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import UIKit
import FavIcon

class ViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var statusLabel: UILabel!
    
    let url = "https://blog.csdn.net/yixiangboy"

    override func viewDidLoad() {
        super.viewDidLoad()

        statusLabel.text = "Loading..."
        do {
            try FavIcon.downloadPreferred(url, width: 200, height: 200) { result in
                if case let .success(image, url) = result {
                    print(url)
                    self.statusLabel.text = "Loaded (\(image.size.width)x\(image.size.height))"
                    self.imageView.image = image
                } else if case let .failure(error) = result {
                    self.statusLabel.text = "Failed: \(error.localizedDescription)."
                    print("failed to download preferred favicon for \(self.url): \(error)")
                }
            }
        } catch let error {
            statusLabel.text = "Failed: \(error.localizedDescription)."
            print("failed to download preferred favicon for \(self.url): \(error)")
        }
    }
}

