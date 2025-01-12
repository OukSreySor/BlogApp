import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlog _getAllBlog;
  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlog getAllBlog,
  }) : _uploadBlog = uploadBlog,
       _getAllBlog = getAllBlog,
       super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlog>(_onFetchAllBlog);
  }
  void _onBlogUpload(
    BlogUpload event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _uploadBlog(UploadBlogParams(
      posterId: event.posterId,
      title: event.title,
      content: event.content,
      image: event.image,
      topics: event.topics,
    ));
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(
        BlogUploadSuccess(),
      ),
    );
  }
  void _onFetchAllBlog(
    BlogFetchAllBlog event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getAllBlog(NoParams());
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(
        BlogDisplaySuccess(r),
      ),
    );
  }
}
