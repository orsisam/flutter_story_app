import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_story_app/data/datasources/story_remote_datasource.dart';
import 'package:flutter_story_app/data/models/story_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_story_event.dart';
part 'create_story_state.dart';
part 'create_story_bloc.freezed.dart';

class CreateStoryBloc extends Bloc<CreateStoryEvent, CreateStoryState> {
  final StoryRemoteDatasource _datasource;

  CreateStoryBloc(this._datasource) : super(CreateStoryState.initial()) {
    on<_Create>(_onCreate);
  }

  Future<void> _onCreate(_Create event, Emitter<CreateStoryState> emit) async {
    emit(const CreateStoryState.loading());

    final result = await _datasource.createStory(
      title: event.title,
      content: event.content,
      image: event.image,
    );

    result.fold(
      (error) => emit(CreateStoryState.error(error)),
      (story) => emit(CreateStoryState.success(story)),
    );
  }
}
