import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/services/tts_service.dart';
import 'features/story_buddy/presentation/bloc/story_buddy_bloc.dart';
import 'features/story_buddy/presentation/pages/story_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PipsStoryAdventureApp());
}

class PipsStoryAdventureApp extends StatelessWidget {
  const PipsStoryAdventureApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pip\'s Story Adventure',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => TtsService(),
        child: BlocProvider(
          create: (context) => StoryBuddyBloc(
            RepositoryProvider.of<TtsService>(context),
          ),
          child: const StoryPage(),
        ),
      ),
    );
  }
}
