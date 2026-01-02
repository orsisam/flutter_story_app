import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_story_app/data/datasources/story_remote_datasource.dart';
import 'package:flutter_story_app/presentation/auth/blocs/login/login_bloc.dart';
import 'package:flutter_story_app/presentation/auth/blocs/logout/logout_bloc.dart';
import 'package:flutter_story_app/presentation/auth/blocs/register/register_bloc.dart';
import 'package:flutter_story_app/presentation/profile/blocs/get_profile/get_profile_bloc.dart';
import 'package:flutter_story_app/presentation/story/blocs/create_story/create_story_bloc.dart';
import 'package:flutter_story_app/presentation/story/blocs/delete_story/delete_story_bloc.dart';
import 'package:flutter_story_app/presentation/story/blocs/get_stories/get_stories_bloc.dart';
import 'package:flutter_story_app/presentation/story/blocs/update_story/update_story_bloc.dart';

// =========================
// DATASOURCE (singleton)
// =========================
final AuthRemoteDatasource _authDatasource = AuthRemoteDatasource();
final StoryRemoteDatasource _storyDatasource = StoryRemoteDatasource();

// =========================
// BLOC PROVIDERS
// =========================
List<BlocProvider> get blocProviders => [
  // Auth BLoCs
  BlocProvider<LoginBloc>(create: (_) => LoginBloc(_authDatasource)),
  BlocProvider<RegisterBloc>(create: (_) => RegisterBloc(_authDatasource)),
  BlocProvider<LogoutBloc>(create: (_) => LogoutBloc(_authDatasource)),

  // Profile BLoC
  BlocProvider<GetProfileBloc>(create: (_) => GetProfileBloc(_authDatasource)),

  // Story BLoCs
  BlocProvider<GetStoriesBloc>(create: (_) => GetStoriesBloc(_storyDatasource)),
  BlocProvider<CreateStoryBloc>(
    create: (_) => CreateStoryBloc(_storyDatasource),
  ),
  BlocProvider<UpdateStoryBloc>(
    create: (_) => UpdateStoryBloc(_storyDatasource),
  ),
  BlocProvider<DeleteStoryBloc>(
    create: (_) => DeleteStoryBloc(_storyDatasource),
  ),
];

// ================================
// HELPER FUNCTION
// ================================
AuthRemoteDatasource get authDatasource => _authDatasource;
StoryRemoteDatasource get storyDatasource => _storyDatasource;
