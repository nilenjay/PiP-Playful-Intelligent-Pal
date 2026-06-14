# Pip's Story Adventure

A single-screen children's educational experience built with Flutter, demonstrating a feature-first clean architecture and event-driven state management using `flutter_bloc`.

## Architecture Choice
This project uses a **Feature-First Clean Architecture (Lightweight)**. 
- Features are encapsulated (e.g., `story_buddy`).
- Abstraction is kept appropriate for the scope. For example, a `StoryRepository` was omitted in favor of static mock data (`story_content.dart`) because there is no remote data source or backend, reducing unnecessary boilerplate.

## State Transition Design (Flutter Bloc)
The application avoids `setState` for business logic, instead relying entirely on a single feature BLoC (`StoryBuddyBloc`).
A single BLoC handles the entire user journey: Story -> Audio Playback -> Quiz Reveal -> Wrong Answer Feedback -> Success Celebration.

**Unified State Model:**
Instead of many separate state classes (`StoryInitial`, `StoryLoading`, etc.), the app uses a unified state (`StoryBuddyState`) with enums (`StoryStatus`, `QuizStatus`). This approach prevents impossible state combinations (e.g., showing a quiz while the story is loading) and makes the UI logic highly predictable.

## TTS Implementation
Audio playback is handled by a dedicated `TtsService` wrapping `flutter_tts`. It provides callbacks for `onStart`, `onComplete`, and `onError` which translate directly into Bloc events. The "Read Me A Story" button is disabled during loading and playback to prevent duplicate requests.

## Data-Driven Quiz Approach
The quiz is strictly data-driven via `QuizModel`. The `QuizSection` widget dynamically renders options based on the provided list of strings, automatically scaling to support 3, 4, or 5 options without any UI code changes.

## Animation Strategy
Animations are separated into reusable, isolated widgets in the `animations/` folder:
- `shake_animation.dart`: Triggers on incorrect answers.
- `slide_reveal_animation.dart`: Reveals the quiz smoothly after narration.
- `star_reward_animation.dart`: Scales and increments the star count on success.

## Error Handling
If TTS fails, an explicit `StoryStatus.error` state is emitted. The UI renders a friendly `ErrorCard` with a retry button, allowing the application to recover gracefully.

## Performance Optimizations & Mid-Range Android Considerations
To ensure 60 FPS on mid-range Android devices (~3GB RAM):
- Extensive use of `const` constructors to prevent unnecessary widget rebuilds.
- Selective rebuilding using `BlocBuilder` `buildWhen` conditions (e.g., only rebuilding the star counter when `starCount` changes).
- Animations are disposed properly to prevent memory leaks.
- Haptic feedback is isolated to a service.

## Caching Approach
Since the application relies on local static data (`StoryContent`), no explicit caching layer was needed. If this were to evolve into a remote-data app, the lightweight structure allows an easy swap to a `Repository` pattern utilizing `shared_preferences` or `hive` for offline caching.

## AI Usage & Judgment
**AI Tools Used:** Generative AI for initial structure and implementation planning.
**Suggestions Accepted:**
- Consolidating into a single `StoryBuddyBloc`. A unified state model for a linear flow simplifies state checks.
- Extracting animations into dedicated widgets (`SlideRevealAnimation`, `ShakeAnimation`).
**Suggestions Rejected / Modified:**
- *Original Suggestion:* Implement a `StoryRepository`.
- *Reasoning:* I rejected this because the project has no backend or complex data retrieval requirements. Creating a mock repository interface adds unnecessary abstraction for an intern challenge. A static data class was sufficient and more readable.
