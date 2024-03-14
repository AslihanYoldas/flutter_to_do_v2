# Flutter To-Do List App with Firebase

A Flutter to-do list app that performs CRUD (Create, Read, Update, Delete) operations, includes a login page using Firebase for authentication, utilizes both SQLite for local storage and Firebase Cloud Firestore for remote data storage, integrates Cubit for state management, employs dependency injection, and incorporates a route generator.

## Feautures
- Firebase Authentication: Implements user authentication using Firebase for secure login.
- CRUD Operations: Allows users to create, read, update, and delete tasks locally and on Firebase Cloud Firestore.
- SQLite Local Storage: Utilizes SQLite for efficient local data storage and retrieval.
- Cubit State Management: Implements the Cubit pattern for effective state management.
- Dependency Injection: Utilizes dependency injection for organized and scalable code.
- Route Generator: Includes a route generator for smooth navigation between different screens.

## Getting Started
To run this project locally, follow these steps:

1. Clone the repository:
``` 
git clone https://github.com/AslihanYoldas/https://github.com/AslihanYoldas/flutter_to_do_v2.git
```
2. Navigate to the project directory:

```
cd flutter_to_do_v2.git
```
3. Install dependencies:
```
flutter pub get
```
4. Configure Firebase:

Create a new Firebase project on the Firebase Console.
Follow the instructions to add your Android and iOS apps to the project.
Download the google-services.json (for Android) and GoogleService-Info.plist (for iOS) configuration files and place them in the appropriate directories (android/app and ios/Runner, respectively).
Enable Email/Password authentication and set up Cloud Firestore in the Firebase Console.

5. Run the app:

``` 
flutter run
``` 

## Screenshots

<img src="screen_shots/login_page.jpeg" alt="login_page" width="200"/>
<img src="screen_shots/create_user.jpeg" alt="create_user" width="200"/>
<img src="screen_shots/firebase_main_page.jpeg" alt="firebase_main_page" width="200"/>
<img src="screen_shots/sql_main_page.jpeg" alt="sql_main_page" width="200"/>
<img src="screen_shots/new_task.jpeg" alt="new_task" width="200"/>
<img src="screen_shots/delete_task.jpeg" alt="delete_task" width="200"/>
<img src="screen_shots/update_task.jpeg" alt="update_task" width="200"/>

## Acknowledgments
- Firebase for providing the authentication and Cloud Firestore services.
- SQLite for local data storage.
- Bloc Package for the Cubit state management.
- Provider Package for dependency injection.
- Flutter for the framework.

## Contributing
Feel free to contribute by opening issues or submitting pull requests. 

## Contact
For questions or feedback, contact aslihanyoldas24@gmail.com


