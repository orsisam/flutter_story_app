import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_story_app/core/constants/variables.dart';
import 'package:flutter_story_app/core/utils/api_handler.dart';
import 'package:flutter_story_app/data/models/stories_response_model.dart';
import 'package:flutter_story_app/data/models/story_model.dart';

class StoryRemoteDatasource {
  // Get my stories (paginated)
  Future<Either<String, StoriesResponseModel>> getMyStories({
    int page = 1,
  }) async {
    final result = await ApiHandler.get('${Variables.myStories}?page=$page');

    return result.fold(
      (error) => Left(error),
      (data) => Right(StoriesResponseModel.fromMap(data)),
    );
  }

  // Create new story
  Future<Either<String, StoryModel>> createStory({
    required String title,
    required String content,
    File? image,
  }) async {
    final result = await ApiHandler.postMultipart(
      Variables.stories,
      fields: {'title': title, 'content': content},
      file: image,
      fileField: 'image',
    );

    return result.fold((error) => Left(error), (data) {
      final storyData = data['data'] as Map<String, dynamic>;
      return Right(StoryModel.fromMap(storyData));
    });
  }

  // Update Story
  Future<Either<String, StoryModel>> updateStory({
    required int id,
    required String title,
    required String content,
    File? image,
  }) async {
    final result = await ApiHandler.postMultipart(
      Variables.storyById(id),
      fields: {'_method': 'PUT', 'title': title, 'content': content},
      file: image,
      fileField: 'image',
    );

    return result.fold((error) => Left(error), (data) {
      final storyData = data['data'] as Map<String, dynamic>;
      return Right(StoryModel.fromMap(storyData));
    });
  }

  // Delete story
  Future<Either<String, String>> deleteStory(int id) async {
    final result = await ApiHandler.delete(Variables.storyById(id));

    return result.fold(
      (error) => Left(error),
      (data) => Right(data['message'] ?? 'Cerita berhasil dihapus'),
    );
  }
}
