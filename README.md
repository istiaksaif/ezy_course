# Ezy Course

Ezy Course is a flutter application designed to provide a comprehensive learning experience with robust community engagement features. The app enables users to access community feeds, interact via posts and reactions, and participate in dynamic discussions with an integrated commenting system.

## Features

- **User Authentication**
    - Secure login and logout functionality to manage user sessions.
- **Default Credentials (for testing):**
    - **Email**: `stu@test.io`
    - **Password**: `123456`
- **Community Feeds**
    - Fetch and display community posts.
    - Add reactions to posts.
    - Post comments with replies.
- **Post Integration**
    - Create, manage, and interact with posts.
- **Interactive UI**
    - Multiple custom icons for enhanced visual consistency.
    - Responsive design built with Flutter.
- **State Management**
    - Efficient and reactive state management powered by GetX.

## Getting Started

### Prerequisites

- [Flutter SDK](Flutter 3.27.4 • channel stable https://flutter.dev/docs/get-started/install) (latest stable version recommended)
- Dart SDK (Dart SDK version: 3.6.2)
- An IDE like Android Studio, VS Code

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/istiaksaif/ezy_course.git

### Folder Structure

lib/
├── controller/         # GetX controllers for managing state (e.g., authentication, feeds, comments, reactions)
├── core/
│   ├── api/            # API clients and networking logic when failed due to network
│   └── utils/          # Utility functions, constants, and helper classes
├── route/              # Application routing and navigation logic
├── model/              # Data models (e.g., CommentModel, CommunityFeedModel) that define the data structure
└── view/               # UI screens and pages
    ├── screen/         # Main screens of the app (e.g., login, community feed, post list)
    ├── dialog/         # Reusable dialog,bottomSheet UI components
    └── widget/         # Reusable widgets/components, buttons, custom inputs filed, app bars
