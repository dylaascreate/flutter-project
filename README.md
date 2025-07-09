# flutter_firebase_crud_lab

A complete Flutter Firebase CRUD application for managing staff registration.

## 📋 Project Overview

This app allows users to **add**, **view**, **edit**, and **delete** staff records using **Cloud Firestore**. Designed with clean UI using Material 3, it supports both mobile and web platforms.

## ✨ Features

- 🔥 Firebase integration (Firestore, Core)
- 📄 Staff registration form with validation
- 📋 Dynamic list of staff entries with live updates
- ✏️ Edit staff details via popup dialog
- 🗑️ Delete staff with confirmation
- 🎨 Material 3-based responsive UI

## 📸 Screenshots

> Firebase interface

1. Cloud Firestore  
<img src="image-5.png" width="1000"/>

> Flutter page

1. Add staff form  
<img src="image.png" width="300"/>
<img src="image-1.png" width="300"/>

2. Staff list  
<img src="image-2.png" width="300"/>

3. Edit staff  
<img src="image-3.png" width="300"/>

4. Delete staff  
<img src="image-4.png" width="300"/>


---

## 🧑‍💻 Tech Stack

| Technology   | Description                           |
|--------------|---------------------------------------|
| Flutter      | Cross-platform UI toolkit             |
| Dart         | Language used by Flutter              |
| Firebase     | Backend services (Firestore & Core)   |
| Firestore    | NoSQL cloud database (real-time sync) |
| Material 3   | Modern UI styling                     |

---

## 🚀 Getting Started

### 1️⃣ Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Firebase project: [Create Firebase Project](https://console.firebase.google.com/)

### 2️⃣ Clone the Repository

```bash
git clone --branch flutter_firebase_crud_lab https://github.com/dylaascreate/flutter-project.git
cd flutter-project
```

### 🗂️ Project Structure

lib/
├── pages/
│   ├── staff_form_page.dart       # Staff registration form
│   └── staff_list_page.dart       # Staff list with edit/delete options
├── firebase_options.dart          # Generated Firebase config
└── main.dart                      # App entry point and theme setup


