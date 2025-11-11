# Arrive IP Locator - Flutter Tech Test

A Flutter Android and iOS app to fetch IP address info and show its approximate location on a map.  
Developed using **MVVM** with clean architecture, **Riverpod**, and Flutter best practices.

---

## Overview
This app allows users to:
- Enter an IP address or use their current IP.
- Fetch approximate latitude and longitude using the [ipapi.co](https://ipapi.co/) API.
- Display the location on **OpenStreetMap**.

---

## Features
- Enter an IP or use your current IP to fetch location.
- Displays latitude & longitude on **OpenStreetMap**.
- Loading indicators and error handling.
- Reusable UI widgets (button, text field, map).
- **MVVM** with clean architecture.
- **Riverpod** for state management.
- Unit, widget, and integration tests included.

---

## Tech Stack
- Flutter 3.x
- Riverpod (State Management)
- flutter_map (OpenStreetMap)
- http (Networking)
- latlong2 (Coordinates)

---

## Service Abstraction
- All API calls go through **HttpService**.
- **Repository** converts JSON to models and handles URLs.
- **ViewModel** uses only the repository, keeping UI decoupled.

This makes it easy to change the networking library or API without affecting the UI or state.

---

## App Screenshot
![Arrive IP Locator Screenshot](assets/screenshots/ip_lookup_screen.png)

---

## Getting Started
```bash
flutter pub get
flutter run
```
---

## Testing
```bash
# Unit and widget tests
flutter test

# Integration tests
flutter test integration_test/
```
---

## Future Improvements
- Better rate-limit handling with retry/backoff.
- More extensive integration test coverage.
- Support for offline map caching.

---
