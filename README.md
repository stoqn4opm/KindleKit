# KindleKit
![](https://img.shields.io/badge/version-1.0-brightgreen.svg)

KindleKit is a micro iOS Dynamic Framework with the single purpose of parsing user's notes and hightlights from Kindle eBook Reader generated 'CSV' files. These csv files user receives when he decides to export its Notes. Then Amazon sends email to user's email containing its notes in `csv` and `pdf` files.

Build using Swift 4.2, Xcode 10, supports iOS 11.0+

# Usage

1. import module **KindleKit** in the file you want to use the framework
2. Invoke the static function `KindleKit.parse(kindleCSV: String)` passing the csv string.
3. In return you will receive `KindleKit.NotesContainer` which is object that contains all data from this csv if it is in valid format.


## Example
```
import UIKit
import KindleKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let parsed = try? KindleKit.parse(kindleCSV: csvString) else { return }
        print(parsed)
    }
}


```

# Installation

### Carthage Installation

1. In your `Cartfile` add `github "stoqn4opm/KindleKit"`
2. Link the build framework with the target in your XCode project

For detailed instructions check the official Carthage guides [here](https://github.com/Carthage/Carthage)

### Manual Installation

1. Download the project and build the shared target called `KindleKit`
2. Add the product in the list of "embed frameworks" list inside your project's target or create a work space with `KindleKit` and your project and link directly the product of `KindleKit`'s target to your target "embed frameworks" list

# Licence

The framework is licensed under MIT licence. For more information see file `LICENCE`
