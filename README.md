⚡ Lightnening Chat
A lightning-fast global chatroom built with Flutter & Firebase, where everyone joins the same conversation. No frills—just pure, real-time messaging!

✨ Features
✅ Instant Global Chat – All users share one lively conversation.
✅ Firebase Auth – Secure sign-up/login with email/password.
✅ Real-Time Updates – Messages sync instantly via Firestore.
✅ Simple & Clean UI – Focus on what matters: the chat.
✅ Cross-Platform – Works on Android, iOS, and Web.

(Future plans: Private messaging, usernames, or themes!)

🛠 Tech Stack
Frontend: Flutter (Dart)

Backend:

Firebase Auth (User management)

Cloud Firestore (Realtime message sync)

State Management: Provider/Riverpod/Bloc (specify yours)

📸 Screenshots
Login Screen	Global Chat
<img src="screenshots/login.png" width="250">	<img src="screenshots/chat.png" width="250">
(Add your actual screenshots here!)

🚀 Quick Start
Clone the repo:

sh
git clone https://github.com/yourusername/lightnening-chat.git
Set up Firebase:

Create a Firebase project and enable Email/Password Auth.

Add your config files (google-services.json, GoogleService-Info.plist).

Run the app:

sh
flutter pub get && flutter run
🔐 Firebase Rules (Firestore)
Ensure your security rules allow global read/write for authenticated users:

javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /messages/{message} {
      allow read, write: if request.auth != null; // All logged-in users can chat
    }
  }
}
❓ Why No Profiles?
Lightnening Chat keeps it simple—no profiles, no distractions. Just one room for everyone to connect!



