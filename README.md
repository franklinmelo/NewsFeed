# Game News iOS App

Welcome to the Game News iOS App! This application provides the latest news and updates from the gaming world, curated from various sources.

## Technologies
- SwiftUI
- Async/Await
- API Requests
- Dependency Injection
- MVVM architecture
- XCTests
- Bazel
- GitHub Action form CI

## Features

- Browse the latest gaming news
- View detailed news articles
- Bookmark favorite articles (in Development)
- Share articles with friends (in Development)

## Requirements

- iOS 17.4+
- Xcode 15.3+
- Swift 5.0+

## Installation

1. Clone the repository:
   ```bash
   git@github.com:franklinmelo/NewsFeed.git
   ```
2. Navigate to the project directory:
    ```bash
    cd NewsFeed
    ```
3. Open the project in Xcode::
    ```bash
    open NewsFeed.xcworkspace
    ```
## Usage
1. Build and run the app on your preferred iOS device or simulator.
2. Explore the latest news by browsing the main feed.
3. Tap on an article to read more details.

## Screenshots
<img width=250 src=https://github.com/user-attachments/assets/d0d97b15-8a85-4131-a9e1-35e51d91ff87>
<img width=250 src=https://github.com/user-attachments/assets/dec1583f-e925-4ce6-a3e9-414b35024a2a>

## Contributing
Contributing
Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch:
  ```bash
git checkout -b feature/your-feature-name
  ```
2. Make your changes and commit them:
  ```bash
git commit -m "Add your feature"
  ```
3. Push to the branch:
  ```bash
git push origin feature/your-feature-name
  ```
4. Create a pull request.

## Bazel
Bazel usage:
1. Install bazel using this link -> https://bazel.build/install/os-x:
2. To build the project:  
  ```bash
bazel build //NewsFeed:NewsFeed
  ```
3. To test the project:
  ```bash
bazel test //NewsFeedTests:NewsFeedTests --test_output=all
  ```
