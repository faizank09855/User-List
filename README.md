# User Details App

This application demonstrates user details management with features including location display, image upload, and persistence using Hive/Sqflite. The app is designed with a responsive UI and implements MVC architecture with GetX for state management.

![Screenshot_1735895631](https://github.com/user-attachments/assets/e1160bb6-1630-468d-bcbb-695f5004cce8)

## Features

1. **Display Current Location**:
   - Shows latitude, longitude, and address at the top of the screen.
2. **Fetch User Details**:
   - Retrieves user details from an API and displays them in a `ListView`.
3. **User Avatars**:
   - Initially displays API-provided avatars for each user.
4. **Image Upload**:
   - Allows image uploads from the gallery or camera.
   - Replaces the API-provided avatar with the uploaded image.
   - Stores the uploaded image locally using Hive/Sqflite for persistence across app restarts.
5. **Responsive Design**:
   - Ensures a user-friendly design that adapts to various screen sizes.

## Architecture

- **MVC Architecture**:
  - Model-View-Controller pattern for clean separation of concerns.
- **State Management**:
  - Utilizes GetX for efficient state management and navigation.

## Permissions

- Access media files (gallery and camera).
- Access location services.

## Setup Instructions

### Prerequisites

1. **Flutter SDK**: Ensure Flutter is installed on your system. [Install Flutter](https://flutter.dev/docs/get-started/install)
2. **API Endpoint**: Replace the placeholder in the `ApiService` with your actual API URL.
3. **Emulator/Device**: Ensure you have a connected device or emulator with the required permissions enabled.

### Installation

1. Clone the repository:
   ```bash
   git clone <repository_url>
   ```
2. Navigate to the project directory:
   ```bash
   cd user_details_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Generate required files for Hive (if using):
   ```bash
   flutter packages pub run build_runner build
   ```
5. Run the app:
   ```bash
   flutter run
   ```

## Usage

### Location Display

- Grant location permissions when prompted.
- The app will display the current latitude, longitude, and address at the top.

### User List

- Fetches user details from the configured API.
- Displays each user's avatar and details in a `ListView`.

### Image Upload

1. Click the upload icon next to a user.
2. Choose the source (Gallery or Camera).
3. After uploading, the image will replace the API-provided avatar.
4. The uploaded image is stored locally and persists across restarts.

### Responsive Design

- The app adapts seamlessly to different screen sizes and orientations.

## Dependencies

- **GetX**: State management and navigation.
- **Hive/Sqflite**: Local storage for uploaded images.
- **Geolocator**: Fetching location details.
- **Permission Handler**: Managing app permissions.
- **Image Picker**: For accessing the gallery and camera.

## Troubleshooting

1. **Permission Issues**:
   - Ensure all required permissions are granted.
   - Use the app settings to manually enable permissions if needed.

2. **API Connectivity**:
   - Check the API endpoint configuration in the `ApiService`.
   - Verify network connectivity.

3. **Storage Persistence**:
   - Ensure Hive/Sqflite is configured correctly.
   - Rebuild the project if necessary after any storage-related changes:
     ```bash
     flutter clean && flutter pub get
     ```

## Contributions

Feel free to fork the repository and submit pull requests for improvements or feature additions.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

