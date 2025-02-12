# Task Nest

A **Flutter** application for managing tasks, built using **Clean Architecture** and the **BLoC pattern** for state management. The app supports **offline storage with Hive** and **cloud sync with Firebase Firestore**, enabling seamless access across multiple devices.

## About this Project

Task Nest is a **lightweight yet powerful task management application** that allows users to **create, update, and delete tasks**. Tasks are stored **locally using Hive**, and they are **synced to Firebase Firestore** when the user is online, ensuring cross-device availability. The app is structured using **Clean Architecture**, making it highly scalable and maintainable.

## Technologies Used

- **Flutter** 3.27.2
- **Dart** 3.6.1
- **BLoC** 9.0.0 (State Management)
- **Hive** 2.2.3 (Local Database)
- **Firebase Firestore** (Cloud Database for cross-device sync)

## Architecture

Task Nest follows **Clean Architecture**, dividing the app into three distinct layers:

### 1️⃣ **Presentation Layer**
- Handles UI and user interactions.
- Uses **BLoC (Business Logic Component)** for efficient state management.

### 2️⃣ **Domain Layer**
- Contains **business logic** and **use cases**.
- Ensures separation of concerns and keeps logic independent of data sources.

### 3️⃣ **Data Layer**
- Manages **local storage using Hive** for offline access.
- Syncs data to **Firebase Firestore** for **real-time, cross-device access**.
- Ensures data consistency between local and cloud storage.

## Why Clean Architecture, BLoC & Firebase Firestore?

✅ **Scalability** – Modular architecture allows for easy feature expansion.  
✅ **Cross-Device Sync** – Firebase Firestore ensures real-time updates across multiple devices.  
✅ **Offline Support** – Tasks are stored in Hive and synced when online.  
✅ **Maintainability** – Well-structured code with separation of concerns.  
✅ **Performance** – Efficient state updates and database operations.

