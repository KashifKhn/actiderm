# ActiDerm

A cross-platform Flutter port of [Sunny](https://github.com/mrdbourke/sunny) — an on-device AI skin-tracking app originally built for iOS. ActiDerm brings the same workflow to both **iOS and Android** using Flutter, Riverpod, and the `flutter_gemma` plugin to run MedGemma entirely on-device.

---

## Credit & Shoutout

This project is a Flutter port of **Sunny**, created by [Daniel Bourke (@mrdbourke)](https://github.com/mrdbourke) as an entry in the [MedGemma Impact Challenge](https://www.kaggle.com/competitions/med-gemma-impact-challenge) on Kaggle.

All credit for the original concept, design, fine-tuned model, and research goes to Daniel. Please check out his work:

| Resource | Link |
|---|---|
| Original Sunny repo | [github.com/mrdbourke/sunny](https://github.com/mrdbourke/sunny) |
| Kaggle writeup | [Sunny — Private Skin Health Tracker](https://kaggle.com/competitions/med-gemma-impact-challenge/writeups/sunny-private-skin-health-tracker) |
| Project video | [YouTube](https://youtu.be/KVxzyWurDQQ) |
| Sunny-MedGemma fine-tuned model (PyTorch) | [HuggingFace](https://huggingface.co/mrdbourke/sunny-medgemma-1.5-4b-finetune) |
| Sunny-MedGemma fine-tuned model (MLX 4-bit) | [HuggingFace](https://huggingface.co/mrdbourke/sunny-medgemma-1.5-4b-finetune-mlx-4bit) |
| Training dataset | [HuggingFace](https://huggingface.co/datasets/mrdbourke/sunny-skin-and-sunscreen-extract-1k) |

---

## What is ActiDerm?

ActiDerm inherits Sunny's core mission: **turn personal skin tracking from a vague intention into an actionable habit.**

Rather than a diagnostic tool, it is a structured self-examination companion. Users photograph skin spots over time, compare changes, and get on-device AI descriptions powered by a fine-tuned MedGemma model — all without any data ever leaving the device.

Key goals:
- Encourage regular (e.g. yearly) self-skin examinations
- Surface potential changes in spots over time
- Generate exportable PDF reports to share with a dermatologist
- Run entirely on-device — zero cloud, zero data sharing

---

## What's Different from the iOS Original?

| | Sunny (iOS) | ActiDerm (Flutter) |
|---|---|---|
| Platform | iOS only | iOS + Android |
| Language | Swift / SwiftUI | Dart / Flutter |
| State management | — | Riverpod |
| Database | CoreData | Drift (SQLite) |
| Navigation | — | GoRouter |
| AI runtime | MLX (on-device) | flutter_gemma (on-device) |
| UI design | iOS-native | Material 3, Outfit font, teal palette |

---

## Features

- **Body map** — tap any body region to view and add skin spots
- **Scan flow** — capture or import photos, attach notes, and run on-device AI analysis
- **Saved scans** — browse all spots with photo history and AI records
- **PDF reports** — generate and share a formatted health report
- **On-device AI** — download and run the MedGemma model locally; no internet required for analysis
- **Biometric lock** — protect records with Face ID, Touch ID, or device PIN
- **Reminders** — scheduled local notifications for periodic skin checks
- **Onboarding** — guided setup including skin type, sun exposure, camera permissions, and AI model download

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3 |
| State | `flutter_riverpod` + `riverpod_annotation` (code-gen) |
| Navigation | `go_router` |
| Database | `drift` (Drift/SQLite) |
| AI | `flutter_gemma` (on-device MedGemma) |
| Models | `freezed` + `json_serializable` |
| Fonts | Google Fonts — Outfit |
| PDF | `pdf` + `printing` |
| Biometrics | `local_auth` |
| Notifications | `flutter_local_notifications` |

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.8.1`
- Android: `minSdk 24`, `compileSdk 36`, NDK `27.0.12077973`
- iOS: Xcode 15+, deployment target iOS 16+

### Install dependencies

```bash
flutter pub get
```

### Code generation

Run after any change to files using `@riverpod`, `@freezed`, `@DriftDatabase`, or `@JsonSerializable`:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Run

```bash
flutter run
```

### Analyze

```bash
flutter analyze
```

### Build

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

---

## Architecture

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   ├── router/
│   └── theme/
├── data/
│   ├── database/          # Drift tables + DAOs
│   └── models/            # Freezed data models
├── services/
│   ├── ai_model/          # flutter_gemma integration
│   ├── biometric_service.dart
│   ├── file_manager_service.dart
│   ├── onboarding_service.dart
│   ├── pdf_report_service.dart
│   └── skin_spot_service.dart
├── features/
│   ├── onboarding/
│   ├── overview/
│   ├── scan/
│   ├── saved_scans/
│   └── settings/
└── shared/
    ├── widgets/
    └── extensions/
```

Each feature owns its own screens, widgets, and providers. Services are global Riverpod providers in `services/`.

---

## Color Palette

| Role | Hex |
|---|---|
| Primary / Brand teal | `#1B6B7B` |
| Heatmap amber | `#F59E0B` |
| Error red | `#DC2626` |
| Success green | `#16A34A` |
| Scaffold (light) | `#F6F8FA` |
| Scaffold (dark) | `#0D1117` |

---

## License

This project is released under the MIT License.

The original Sunny iOS app and its associated model, dataset, and research are the work of [Daniel Bourke](https://github.com/mrdbourke). Please refer to the [original repository](https://github.com/mrdbourke/sunny) for its license terms.
