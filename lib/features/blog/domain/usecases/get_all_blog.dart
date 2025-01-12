import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';


class GetAllBlog implements UseCase<List<Blog>, NoParams>{
  final BlogRepository blogRepository;
  GetAllBlog(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async{
    return await blogRepository.getAllBlogs();
    
  }
  
}