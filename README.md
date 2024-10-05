# Flutter TODO Application

A simple **TODO** application built with **Flutter** that performs CRUD operations using **SQLite** as local storage. The app allows users to add, edit, delete, and mark tasks as complete, providing an intuitive way to manage daily tasks.

## Features

- **Add New Tasks**: Users can create new TODO tasks with a title and description.
- **View Tasks**: Displays a list of all tasks, categorized by status (Pending or Completed).
- **Update Tasks**: Allows users to edit task details.
- **Delete Tasks**: Delete completed or unnecessary tasks.
- **Mark as Complete**: Users can mark tasks as completed or revert them to pending status.
- **Persistent Storage**: All tasks are stored locally using SQLite and remain saved even after the app is closed.


## Installation

To run this Flutter TODO app locally, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/MohamedSci/Todo-App-Flutter.git
   ```

2. Navigate to the project directory:
   ```bash
   cd flutter-todo-app
   ```

3. Install the required dependencies:
   ```bash
   flutter pub get
   ```

4. Run the application:
   ```bash
   flutter run
   ```

### Prerequisites

- **Flutter** SDK installed (version 3.x or higher).
- **Dart** SDK (included with Flutter).
- **SQLite** plugin for Flutter is already integrated into the project.

## Database Setup

The app uses **SQLite** as a local database to store tasks. The **sqflite** plugin is used to handle the database operations. 

The database schema consists of a single table:
- **tasks**:
  - `id` (integer, primary key)
  - `title` (text)
  - `description` (text)
  - `status` (integer: 0 for pending, 1 for completed)

The database file is created and managed automatically by the app and stored in the local app storage.

## Packages Used

- [sqflite](https://pub.dev/packages/sqflite) - SQLite plugin for Flutter.
- [path_provider](https://pub.dev/packages/path_provider) - Used to locate paths in the file system for storing the SQLite database.
- [provider](https://pub.dev/packages/provider) - For state management in the app.

## Usage

1. **Add a Task**: Click on the `+` button to add a new task with a title and description.
2. **Edit a Task**: Tap on any task in the list to update the task details.
3. **Delete a Task**: Swipe a task left or right to delete it.
4. **Mark as Complete**: Tap the checkbox to mark a task as completed or revert it back to pending.


## How to Contribute

If you'd like to contribute to this project, follow these steps:

1. Fork the repository.
2. Create a new feature branch (`git checkout -b feature-branch`).
3. Implement your changes.
4. Commit your changes (`git commit -m 'Add new feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Create a Pull Request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## [Buy me a Coffee☕](<https://ko-fi.com/mohamedsaidibrahim>)

If you enjoy this content and want to support me, feel free to [buy me a coffee](<https://ko-fi.com/mohamedsaidibrahim>)


---
