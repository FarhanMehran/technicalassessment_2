
CollageView App

A simple iOS application that displays a custom collage view divided into three tappable sections. Users can tap on any section to pick and display images, with borders around each section.

Features

- Custom Collage Layout: The view is divided into three sections, where each section can display an image.
- Tap Gesture Support: Users can tap on any section of the collage to trigger an image picker.
- Borders Around Sections: Each section has a customizable border, making it easy to distinguish the sections.
- Image Picker: Upon tapping a section, the image picker is presented, allowing users to select an image from their library.
- Auto Layout: The view is constrained with Auto Layout, ensuring a flexible design that works across different device sizes.

 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/your-repository.git
   ```

2. Open the project in Xcode:
   ```bash
   cd your-repository
   open CollageView.xcodeproj
   ```

3. Build and run the project on an iOS device or simulator:
   - Ensure you have a development team set up in Xcode for image picker functionality.

 Usage

 Custom Collage Layout
The `CollageView` class handles the collage view. It divides the screen into three sections:
- Top Left
- Top Right
- Bottom Full Width

Each section has its own tappable area to select and display images.

 Setting Up the View
The `CollageView` is initialized in the `ViewController` and added to the view. Auto Layout constraints are used to set its size and position within the view.

```swift
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collageView = CollageView()
        collageView.backgroundColor = .gray
        self.view.addSubview(collageView)

        // Disable autoresizing mask translation to constraints
        collageView.translatesAutoresizingMaskIntoConstraints = false

        // Set constraints from top and bottom
        NSLayoutConstraint.activate([
            collageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            collageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            collageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])

        self.view.backgroundColor = .white
    }
}
```

 Image Selection
When a user taps on a section of the collage, the `ImagePickerManager` is used to select an image from the device’s photo library. The selected image is then displayed in the tapped section.

 Key Classes

 `CollageView`
This class is responsible for:
- Creating and laying out the collage sections using `CAShapeLayer`.
- Handling tap gestures on the sections.
- Managing the display of selected images.

 `ImagePickerManager`
A helper class that manages the interaction with the photo library and provides selected images.

 Requirements

- iOS 13.0+
- Swift 5
- Xcode 12.0+

 Screenshots

 Default Layout
Collage view before selecting images.

![Default Layout](images/default.png)

 Image Selection
Collage view after selecting an image.

![Image Selection](images/selected.png)

