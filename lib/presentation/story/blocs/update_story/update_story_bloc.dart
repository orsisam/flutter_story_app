import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_story_app/data/datasources/story_remote_datasource.dart';
import 'package:flutter_story_app/data/models/story_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_story_event.dart';
part 'update_story_state.dart';
part 'update_story_bloc.freezed.dart';

class UpdateStoryBloc extends Bloc<UpdateStoryEvent, UpdateStoryState> {
  final StoryRemoteDatasource _datasource;
  UpdateStoryBloc(this._datasource) : super(UpdateStoryState.initial()) {
    on<_Update>(_onUpdate);
  }

  Future<void> _onUpdate(_Update event, Emitter<UpdateStoryState> emit) async {
    emit(UpdateStoryState.loading());

    final result = await _datasource.updateStory(
      id: event.id,
      title: event.title,
      content: event.content,
      image: event.image,
    );

    result.fold(
      (error) => emit(UpdateStoryState.error(error)),
      (story) => emit(UpdateStoryState.success(story)),
    );
  }
}
