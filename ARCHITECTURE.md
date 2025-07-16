# Architecture Documentation

## Overview

The Anime Facts iOS app follows **Clean Architecture** principles with a clear separation of concerns across different layers. This architecture ensures maintainability, testability, and scalability while following SOLID principles.

## Architecture Layers

### 1. **Presentation Layer** (`Presenter/`)
The outermost layer responsible for UI logic and user interaction handling.

#### Components:
- **Views** (`View/`): UIViewControllers, custom UIViews, and UITableViewCells
- **ViewModels** (`ViewModel/`): Presentation logic, UI state management, and reactive bindings
- **Models** (`Model/`): UI-specific data models and view states

#### Key Features:
- **MVVM Pattern**: Separates UI logic from business logic
- **Reactive Programming**: Uses RxSwift for data binding and state management
- **Dependency Injection**: ViewModels are injected with use cases

```swift
// Example: ViewModel Protocol
protocol AnimeViewModelProtocol: AnyObject {
    var animesArray: [Anime] { get }
    var bindingCases: BehaviorSubject<BindingCases> { get }
    func fetchAnimes(_ season: Season)
    func numberOfRowsInSection() -> Int
}
```

### 2. **Domain Layer** (`Domain/`)
The core business logic layer containing enterprise business rules.

#### Components:
- **Repository Interfaces** (`Repo/`): Contracts for data access operations
- **Use Cases** (in `Data/UseCase/`): Business logic implementation
- **Entities**: Core business models (Anime, Season)

#### Key Features:
- **Repository Pattern**: Abstracts data access from business logic
- **Use Case Pattern**: Encapsulates business operations
- **Protocol-Oriented**: Defines contracts for data operations

```swift
// Example: Repository Protocol
protocol AnimeRepo: AnyObject {
    func animes(year: String, season: Season) -> Single<AnimeRequest>
    func currentSeasonAnimes() -> Single<AnimeRequest>
}
```

### 3. **Data Layer** (`Data/`)
Handles data access, API communication, and external data sources.

#### Components:
- **Repository Implementations** (`Repo/`): Concrete implementations of domain interfaces
- **Use Cases** (`UseCase/`): Business logic that coordinates between repositories
- **Network Layer** (`NetworingMoya/`): API communication using Moya

#### Key Features:
- **Single Responsibility**: Each repository handles one data source
- **Error Handling**: Consistent error mapping and handling
- **Reactive Streams**: Returns RxSwift observables for async operations

```swift
// Example: Repository Implementation
class AnimeRepoImplementation: AnimeRepo {
    @Injected private var network: AnimeNetwork
    
    func animes(year: String, season: Season) -> Single<AnimeRequest> {
        return network.fetchAnime(year: year, season: season)
    }
}
```

### 4. **Network Layer** (`NetworingMoya/`)
Handles all external API communication and network operations.

#### Components:
- **API Targets** (`AnimeTarget.swift`): Defines API endpoints using Moya
- **Network Providers** (`AnimeProvider.swift`): Concrete network implementations
- **Network Injection** (`AnimeNetworkInjection.swift`): Dependency registration

#### Key Features:
- **Moya Integration**: Type-safe API layer
- **Protocol Abstraction**: Network operations are protocol-based
- **Error Handling**: Custom error types for network failures

### 5. **Dependency Injection** (`Application+Inject/`)
Manages dependencies across all layers using the Resolver pattern.

#### Components:
- **Service Registration**: Configures all app dependencies
- **Scope Management**: Controls object lifecycles
- **Module Organization**: Feature-specific injection modules

```swift
// Example: Dependency Registration
extension Resolver {
    static func animeDependicesService() {
        register { AnimeRepoImplementation() }
            .implements(AnimeRepo.self)
        
        register { AnimeUseCase() }
            .implements(AnimeUseCaseProtocol.self)
    }
}
```

## Design Patterns

### 1. **Repository Pattern**
Abstracts data access logic from business logic.

**Benefits:**
- Testability through protocol abstraction
- Flexibility to change data sources
- Clear separation of concerns

### 2. **Use Case Pattern**
Encapsulates business logic operations.

**Benefits:**
- Single responsibility for business operations
- Reusable across different presentation layers
- Independent of UI frameworks

### 3. **MVVM (Model-View-ViewModel)**
Separates presentation logic from UI.

**Benefits:**
- Testable presentation logic
- Reactive UI updates
- Clean separation of concerns

### 4. **Dependency Injection**
Manages object dependencies and lifecycles.

**Benefits:**
- Loose coupling between components
- Easy testing with mock objects
- Centralized dependency management

## Data Flow

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│     View    │───▶│  ViewModel  │───▶│   UseCase   │───▶│ Repository  │
│             │    │             │    │             │    │             │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
       ▲                   ▲                   ▲                   ▲
       │                   │                   │                   │
       │                   │                   │                   ▼
       │                   │                   │            ┌─────────────┐
       │                   │                   │            │   Network   │
       │                   │                   │            │   Provider  │
       │                   │                   │            └─────────────┘
       │                   │                   │                   │
       │                   │                   │                   ▼
       │                   │                   │            ┌─────────────┐
       │                   │                   │            │     API     │
       │                   │                   │            │  (Jikan)    │
       │                   │                   │            └─────────────┘
       │                   │                   │
       │                   │                   ▼
       │                   │            ┌─────────────┐
       │                   │            │    Error    │
       │                   │            │  Handling   │
       │                   │            └─────────────┘
       │                   │
       │                   ▼
       │            ┌─────────────┐
       │            │   Reactive  │
       │            │   Binding   │
       │            │  (RxSwift)  │
       │            └─────────────┘
       │
       ▼
┌─────────────┐
│  UI Update  │
│  Animation  │
│  Loading    │
└─────────────┘
```

## Error Handling Strategy

### 1. **Layered Error Handling**
Each layer handles and transforms errors appropriately:

- **Network Layer**: Raw network errors
- **Repository Layer**: Domain-specific errors
- **Use Case Layer**: Business logic errors
- **ViewModel Layer**: UI-friendly error messages

### 2. **Custom Error Types**
```swift
enum AnimeNetworkError: Error, LocalizedError {
    case invalidYear
    case noDataAvailable
    case apiKeyMissing
    case networkTimeout
    case decodingError
}
```

### 3. **Reactive Error Handling**
Uses RxSwift's error handling operators:
- `catch`: Transform errors
- `retry`: Retry failed operations
- `do(onError:)`: Side effects for errors

## Testing Strategy

### 1. **Unit Tests**
- **ViewModels**: Test presentation logic
- **Use Cases**: Test business logic
- **Repositories**: Test data access logic

### 2. **Integration Tests**
- **Network Layer**: Test API communication
- **End-to-End**: Test complete user flows

### 3. **Mock Objects**
- Protocol-based design enables easy mocking
- Dependency injection facilitates test double injection

## Code Organization

### Directory Structure
```
Anime-Facts/
├── Core/                      # App lifecycle
├── Modules/                   # Feature modules
│   ├── Anime/                # Anime feature
│   │   ├── Domain/           # Business logic contracts
│   │   ├── Data/             # Data access implementations
│   │   └── Presenter/        # UI layer
│   └── Synopsis/             # Synopsis feature
├── NetworingMoya/            # Network layer
├── Extensions/               # Utility extensions
└── Application+Inject/       # Dependency injection
```

### Naming Conventions
- **Protocols**: End with protocol type (e.g., `AnimeRepo`, `AnimeUseCaseProtocol`)
- **Implementations**: Descriptive names (e.g., `AnimeRepoImplementation`)
- **ViewModels**: End with `ViewModel` (e.g., `AnimeViewModel`)
- **Use Cases**: End with `UseCase` (e.g., `AnimeUseCase`)

## Benefits of This Architecture

### 1. **Maintainability**
- Clear separation of concerns
- Easy to locate and modify specific functionality
- Consistent patterns across features

### 2. **Testability**
- Protocol-based design enables easy mocking
- Each layer can be tested independently
- Business logic is separated from UI

### 3. **Scalability**
- Easy to add new features following existing patterns
- Modular architecture supports large teams
- Clear boundaries between components

### 4. **Flexibility**
- Easy to change data sources
- UI framework independence
- Supports different presentation patterns

## Future Enhancements

### 1. **Caching Layer**
- Add local data persistence
- Implement cache strategies
- Offline support

### 2. **Error Recovery**
- Automatic retry mechanisms
- Graceful degradation
- User-friendly error recovery

### 3. **Performance Optimization**
- Image caching strategies
- Background processing
- Memory management

### 4. **Security Enhancements**
- API key management
- Certificate pinning
- Data encryption