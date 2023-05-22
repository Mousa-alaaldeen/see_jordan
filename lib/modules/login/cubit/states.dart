import '../../../models/login_model.dart';
import '../../../models/updat.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLodingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginModel model;
  LoginSuccessState(this.model);
}

class LoginErrorState extends LoginState {
  final LoginModel error;
  LoginErrorState(this.error);
}

class LoginPasswordIsVisibilityState extends LoginState {}

class UpdateNameLodingState extends LoginState {}

class UpdateNameSuccessState extends LoginState {
  final UpdatNameModel model;

  UpdateNameSuccessState(this.model);
}

class UpdateNameErrorState extends LoginState {}

class GetUserDataLodingState extends LoginState {}

class GetUserDataSuccessState extends LoginState {
  final LoginModel model;

  GetUserDataSuccessState(this.model);
}

class GetUserDataErrorState extends LoginState {}

/// post
class CreatePostLodingState extends LoginState {}

class CreatePostSuccessState extends LoginState {}

class CreatePostErrorState extends LoginState {}

class GetPostLodingState extends LoginState {}

class GetPostSuccessState extends LoginState {}

class GetPostErrorState extends LoginState {}

class ChangeSelectedCommemt extends LoginState {}

//delete post
class DeletePostLodingState extends LoginState {}

class DeletePostSuccessState extends LoginState {}

class DeletePostErrorState extends LoginState {}

//comment
class CreateCommentLodingState extends LoginState {}

class CreateCommentSuccessState extends LoginState {}

class CreateCommentErrorState extends LoginState {}

class DeleteCommentLodingState extends LoginState {}

class DeleteCommentSuccessState extends LoginState {}

class DeleteCommentErrorState extends LoginState {}

//imag
class UpdateImageprofileSuccessState extends LoginState {}

class UpdateImageprofileErrorState extends LoginState {}
class UpdateImageCoverSuccessState extends LoginState {}

class UpdateImageCoverErrorState extends LoginState {}

class RemoveImagePostState extends LoginState {}

class PostImageSuccessState extends LoginState {}

class PostImageErrorState extends LoginState {}

class RemovePostImageState extends LoginState {}

//profile
class GetProfileLodingState extends LoginState {}

class GetProfileSuccessState extends LoginState {}

class GetProfileErrorState extends LoginState {}

//Bio
class UpdateBioLodingState extends LoginState {}

class UpdateBioSuccessState extends LoginState {}

class UpdateBioErrorState extends LoginState {}

//like
class LikeSuccessState extends LoginState {}

class LikePostSuccessState extends LoginState {}

class LikePostErrorState extends LoginState {}

class DeleteLikePostSuccessState extends LoginState {}

class DeleteLikePostErrorState extends LoginState {}
