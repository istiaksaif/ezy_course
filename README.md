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

<ul>
  <li><strong>lib/</strong></li>
  <ul>
    <li><strong>controller/</strong> - GetX controllers for managing state (e.g., authentication, feeds, comments, reactions)</li>
    <li><strong>core/</strong> - API clients and networking logic when failed due to network</li>
    <ul>
      <li><strong>api/</strong> - API clients and networking logic when failed due to network</li>
      <li><strong>utils/</strong> - Utility functions, constants, and helper classes</li>
    </ul>
    <li><strong>route/</strong> - Application routing and navigation logic</li>
    <li><strong>model/</strong> - Data models (e.g., CommentModel, CommunityFeedModel) that define the data structure</li>
    <li><strong>view/</strong> - UI screens and pages</li>
    <ul>
      <li><strong>screen/</strong> - Main screens of the app (e.g., login, community feed, post list)</li>
      <li><strong>dialog/</strong> - Reusable dialog, bottomSheet UI components</li>
      <li><strong>widget/</strong> - Reusable widgets/components, buttons, custom inputs fields, app bars</li>
    </ul>
  </ul>
</ul>
