# Community Feed Application

This is a community feed application built using **Flutter**, allowing users to authenticate, create posts, react to posts, comment, reply to comments, and more. The app dynamically fetches posts from a provided API and displays them in a scrollable feed.

## Features

- **Authentication**
    - Secure login and logout functionality to clear user sessions.
- **Default Credentials (for testing):**
    - **Email**: `stu@test.io`
    - **Password**: `123456`
- **Community Feeds**
    - Fetch and display community posts.
    - Add/Update reactions to posts.
    - Post comments with replies.
    - real-time updates, ensuring that newly created posts, reactions, and comments are displayed immediately without requiring the user to refresh the page.
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

### Folders Breakdown

- **controller/**: Contains all the GetX controllers that manage state for various features like authentication, feeds, comments, reactions, etc.
- **core/api/**: Handles the API calls and responses for fetching posts, submitting posts, comments, etc.
- **core/utils/**: Contains utility functions, constants, and helper classes used throughout the app.
- **route/**: Manages routing and navigation logic between screens.
- **model/**: Defines the data models such as `PostModel`, `CommentModel`, and others used in the app.
- **view/**: Contains UI screens and pages (e.g., `LoginScreen`, `FeedScreen`, `PostDetailsScreen`).
    - **screen/**: Major screens like login, home, post details.
    - **widget/**: Reusable UI components like buttons, text fields, etc.
    - **dialog/**: Custom dialogs, if any.