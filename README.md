### How to Clone, Set Up, and Run TakeCare on Your Own Device:

#### Prerequisites:
1. **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install) on your machine.
2. **Firebase Setup**: Ensure you have a Firebase project set up and the necessary credentials (Google Services JSON/Plist files).

#### Steps to Clone and Set Up:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/takecare.git
   cd takecare
   ```

2. **Install Dependencies**:
   Run the following command to install all required packages:
   ```bash
   flutter pub get
   ```

3. **Set Up Firebase**:
   - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) from your Firebase project.
   - Place the `google-services.json` file in the `android/app` directory and `GoogleService-Info.plist` in the `ios/Runner` directory.

4. **Run the App**:
   To launch the app on your device or emulator, use the following command:
   ```bash
   flutter run
   ```

You should now have the **TakeCare** app running on your device, fully functional with Firebase integration and the Gemini chatbot.

- **Comprehensive Support:** Combines assessments, smart assistance, and educational content.
- **Accessibility:** User-friendly interface for easy navigation and resource access.
- **Awareness:** Promotes mental health education and reduces stigma.

This app aims to be a valuable resource for mental health support and awareness, ensuring users have access to the help they need anytime, anywhere.

---

# TakeCare

### Mental Health App Overview

**Objective:** A Flutter-based app designed to assist individuals with mental health concerns and raise awareness through interactive features and personalized guidance.

#### Key Features:

1. **Smart Assistance:**
   - Integrated **Gemini API** for personalized chatbot support.

2. **Self-Assessment Tests:**
   - Tests for ADHD, PTSD, Bipolar Disorder, Anxiety, and Depression.
   - Immediate feedback and relevant recommendations provided.

3. **Educational Resources:**
   - Access to audiobooks, articles, and videos on mental health.
   - Resources are dynamically fetched from a central database.

#### Technologies Used:

- **Flutter & Dart:** Ensure a smooth, cross-platform user experience.
- **Firebase:** Supports user authentication, a real-time database, and cloud storage for data management.

#### Benefits:
- Offers personalized mental health support and guidance.
- Enables users to assess their mental health and receive insights.
- Provides easy access to educational resources to improve mental health awareness.

---
