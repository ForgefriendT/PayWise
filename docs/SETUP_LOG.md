# PayWise Setup Log

This log lists each tool installed and the command used to install it.

- Checked Flutter environment: `flutter doctor`
- Installed GitHub CLI: `brew install gh`
- Verified Firebase CLI: pre-installed at `/opt/homebrew/bin/firebase`
- Verified FlutterFire CLI: pre-installed at `/Users/fauzanbaig/.pub-cache/bin/flutterfire`
- Initialized Flutter project: `flutter create --org com.paywise --project-name paywise --platforms=android,ios,web .`
- Initialized Git repository: `git init`
- Added approved packages: `flutter pub add firebase_core firebase_auth cloud_firestore provider go_router flutter_svg fl_chart flutter_animate google_fonts intl mobile_scanner`
- Configured Firebase options for Android and Web: `flutterfire configure --project=paywise-ae977 --platforms=android,web -y`
- Deployed Firestore security rules and initialized database: `firebase deploy --only firestore:rules`
- Deployed web application to Firebase Hosting: `firebase deploy --only hosting`
- Implemented Firestore data models, FirestoreService gateway, and AuthService
- Created Stitch-matched LoginScreen with demo anonymous sign-in and procedural demo seeding
- Pushed M2 milestone to GitHub repository: `git push origin main`

