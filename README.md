# Anime Facts iOS App

A modern iOS application that displays seasonal anime information using Clean Architecture principles, RxSwift, and Moya for networking.

## 🚀 Features

- **Seasonal Anime Browsing**: View anime by different seasons (Winter, Spring, Summer, Fall)
- **Clean Architecture**: Well-structured codebase following SOLID principles
- **Reactive Programming**: Built with RxSwift for responsive UI updates
- **Modern UI**: Uses SkeletonView for loading states and SnapKit for Auto Layout
- **Dependency Injection**: Implements Resolver pattern for clean dependency management
- **Image Loading**: Kingfisher for efficient image loading and caching

## 🏗️ Architecture Overview

The app follows Clean Architecture with the following layers:

### 1. **Presentation Layer**
- **Views**: UIViewControllers and custom UIView components
- **ViewModels**: Business logic for UI, reactive bindings
- **Models**: UI-specific data models

### 2. **Domain Layer**
- **Repository Interfaces**: Protocols defining data access contracts
- **Use Cases**: Business logic implementation

### 3. **Data Layer**
- **Repository Implementations**: Concrete implementations of domain interfaces
- **Network Layer**: Moya-based API communication

### 4. **Dependency Injection**
- **Resolver**: Manages dependencies across all layers

## 📱 App Structure

```
Anime-Facts/
├── Core/                          # App lifecycle management
├── Modules/                       # Feature modules
│   ├── Anime/                    # Main anime listing feature
│   │   ├── Domain/              # Business logic interfaces
│   │   ├── Data/                # Data access implementations
│   │   └── Presenter/           # UI layer
│   └── Synopsis/                # Anime details feature
├── NetworkingMoya/              # API layer
├── Extensions/                  # Utility extensions
├── Application+Inject/          # DI configuration
└── Supporting/                  # Supporting files
```

## 🛠️ Dependencies

- **RxSwift/RxCocoa**: Reactive programming
- **Moya**: Network abstraction layer
- **Resolver**: Dependency injection
- **SkeletonView**: Loading state animations
- **SnapKit**: Auto Layout DSL
- **Kingfisher**: Image loading and caching
- **RxDataSources**: Reactive data sources for UITableView/UICollectionView

## 📋 Requirements

- iOS 12.0+
- Xcode 12.0+
- Swift 5.0+
- CocoaPods

## 🚀 Getting Started

### Installation

1. **Clone the repository**
   ```bash
   git clone [repository-url]
   cd Anime-Facts
   ```

2. **Install dependencies**
   ```bash
   pod install
   ```

3. **Open workspace**
   ```bash
   open Anime-Facts.xcworkspace
   ```

4. **Build and run**
   - Select your target device/simulator
   - Press Cmd+R to build and run

### API Configuration

The app uses the Jikan API for anime data. Update the API key in `AnimeTarget.swift`:

```swift
var headers: [String : String]? {
    return ["X-RapidAPI-Key": "YOUR_API_KEY_HERE",
            "X-RapidAPI-Host":"jikan1.p.rapidapi.com"]
}
```

## 🧪 Testing

### Unit Tests
```bash
# Run tests
Cmd+U in Xcode
```

### UI Tests
```bash
# Run UI tests
Cmd+U in Xcode (select UI test target)
```

## 🚢 Deployment

### TestFlight Deployment

Use the provided shell script:

```bash
./deploy-testflight.sh
```

This script will:
- Install Homebrew (if not present)
- Install Fastlane
- Run the configured Fastlane lane for TestFlight deployment

### Manual Deployment

1. **Archive the project**
   ```
   Product → Archive
   ```

2. **Upload to App Store Connect**
   - Use Xcode Organizer
   - Select "Distribute App"
   - Choose "App Store Connect"

## 📚 Code Style

- Follow Swift API Design Guidelines
- Use meaningful variable and function names
- Add documentation for public APIs
- Keep functions small and focused
- Use dependency injection for testability

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- [Jikan API](https://jikan.moe/) for anime data
- [RxSwift Community](https://github.com/ReactiveX/RxSwift) for reactive programming
- [Moya Community](https://github.com/Moya/Moya) for networking abstraction