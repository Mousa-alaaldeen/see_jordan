// ignore_for_file: avoid_print, unused_local_variable, deprecated_member_use, unused_element, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, avoid_types_as_parameter_names, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:cubit_form/cubit_form.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/login/cubit/states.dart';
import 'package:flutter_application_1/modules/post/post.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/bio_model.dart';
import '../../../models/comment_model.dart';
import '../../../models/login_model.dart';
import '../../../models/post_model.dart';
import '../../../models/profile_model.dart';
import '../../../models/register_model.dart';
import '../../../models/updat.dart';
import '../../../shared/components/constantes.dart';
import '../../../shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData iconData = Icons.remove_red_eye;
  void passwordVisibility() {
    isPassword = !isPassword;
    iconData = isPassword
        ? iconData = Icons.remove_red_eye
        : Icons.visibility_off_outlined;

    emit(LoginPasswordIsVisibilityState());
  }

  RegisterModel? registerModel;
  String? myMapString;

  // LoginModel? login;
  // void getUserData() {
  //   emit(GetUserDataLodingState());
  //   DioHelper.getData(url: 'Authentication/login', token: 'Bearer $token')
  //       .then((value) {
  //     login = LoginModel.fromJson(value.data);
  //     print('555555555555');
  //     print(login!.data!.firstName);
  //     emit(GetUserDataSuccessState(login!));
  //   }).catchError((error) {
  //     emit(GetUserDataErrorState());
  //   });
  // }

  List<LoginModel> er = [];
  LoginModel? loginModel;
  String firetName = "";
  String getUrlComment = "";
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLodingState());
    DioHelper.postData(url: 'Authentication/login', data: {
      'username': email,
      'password': password,
    }).then((value) {
      print('+++++');
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print('name');

      firetName = loginModel!.data!.firstName!;
      print(loginModel!.data!.firstName);

      print('+++++');
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      loginModel = LoginModel.fromJson(error.response.data);
      print('888888888888888888888');

      print(loginModel!.errorData!.username);
      emit(
        LoginErrorState(loginModel!),
      );
    });
  }

  UpdatNameModel? updateNameModel;
  void updateName({
    String? firstname,
    String? lastname,
  }) {
    emit(UpdateNameLodingState());
    DioHelper.putData(
        url: 'ProfileSetting/updateName',
        token: 'Bearer $token',
        data: {
          'firstname': firstname!,
          'lastname': lastname!,
        }).then((value) {
      updateNameModel = UpdatNameModel.fromJson(value.data);

      print(updateNameModel!.data!.lastname);
      print('+++++++');

      emit(UpdateNameSuccessState(updateNameModel!));
    }).catchError((error) {
      error.toString();
      emit(UpdateNameErrorState());
    });
  }

  BioModel? bioModel;
  void updateBio({
    String? bio,
  }) {
    emit(UpdateBioLodingState());
    DioHelper.putData(
        url: 'ProfileSetting/updateBio',
        token: 'Bearer $token',
        data: {
          'bio': bio!,
        }).then((value) {
      bioModel = BioModel.fromJson(value.data);
      print(updateNameModel!.data!.lastname);
      print('+++++++');

      emit(UpdateBioSuccessState());
    }).catchError((error) {
      error.toString();
      print(error.toString());
      emit(UpdateBioErrorState());
    });
  }

  List<PostModel> postModel = [];

  CommentModel? commentModel;
  void getPosts() {
    emit(GetPostLodingState());
    DioHelper.getData(
      url: 'Posts',
      token: 'Bearer $token',
    ).then((value) {
      postModel = PostDataModel.formJson(value.data).list;
      // print(postModel[0].postId.toString());
      // print(postModel[0].poster);
      print(postModel.length);

      // for (var element in postModel) {
      //   postModel.add(PostModel.fromJson(element));
      // }

      print('>>>>>>>>>>');
      print(token);
      print(userId);
      print('api/Posts/comment$userId');
      getUrlComment = 'Posts/comment/$userId';
      print(getUrlComment);
      print(postModel.toString());
      emit(GetPostSuccessState());
    }).catchError((error) {
      print('>>>>>>>>>>77');
      print(error.toString());
      emit(GetPostErrorState());
    });
  }

  void createComment(
      {required String postId,
      required String userId,
      String? comment,
      commentText,
      index,
      context}) async {
    emit(CreateCommentLodingState());

    const url = 'http://www.ma511.somee.com/api/Posts/comment';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        // 'Content-Type': 'application/json',
        // 'lang': lang,
        'Authorization': 'Bearer $token',
      },
      body: {
        'PostId': postId,
        'UserId': userId,
        'description': comment,
      },
    ).then((value) {
      //   //CModel commentModel = CModel.fromJson(value.data);

      emit(CreateCommentSuccessState());
    }).catchError((error) {
      print(error.response.data);
      emit(CreateCommentErrorState());
    });
  }

  void createC({
    required String userId,
    String? comment,
  }) async {
    emit(CreateCommentLodingState());

    const url = 'http://www.ma511.somee.com/api/Posts';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        // 'Content-Type': 'multipart/form-data',
        // 'Content-Type': 'application/json',
        // 'lang': lang,
        'Authorization': 'Bearer $token',
      },
      body: {
        'UserId': userId,
        'description': comment,
        'Poster': postImage,
      },
    ).then((value) {
      //   //CModel commentModel = CModel.fromJson(value.data);
      emit(CreateCommentSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateCommentErrorState());
    });
  }

  Future ConvertImag(File imag) async {
    Uint8List im = await postImage!.readAsBytes();
    String bae = base64.encode(im);
  }

  File? postImage;

  var picker = ImagePicker();
  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    // print(postImage!);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);

      emit(PostImageSuccessState());
    } else {
      print('No image selected');
      emit(PostImageErrorState());
    }
    print(postImage!);
  }

  void removePostImage() {
    storieImage = null;

    emit(RemoveImagePostState());
  }

  File? storieImage;
  var pickers = ImagePicker();
  String imagename = '';
  Future<void> getImage() async {
    final pickerFile = await pickers.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      storieImage = File(pickerFile.path);
      imagename = pickerFile.name;
      print(storieImage!.path);
      emit(PostImageSuccessState());
    } else {
      print('No Image ');
      emit(PostImageErrorState());
    }
  }

  File? profilImage;
  Future<void> getprofilImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profilImage = File(pickedFile.path);
      print(profilImage!.path);
      emit(PostImageSuccessState());
    } else {
      print('No image selected');
      emit(PostImageErrorState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(coverImage!.path);
      emit(PostImageSuccessState());
    } else {
      print('No image selected');
      emit(PostImageErrorState());
    }
  }

  uploadImage({
    required String userId,
    String? post,
    File? file,
  }) async {
    emit(CreatePostLodingState());
    final dio = Dio();
    // MultipartFile test = await MultipartFile.fromFile(file!.path,
    //     contentType: MediaType('image', 'png'));
    const url = 'http://www.ma511.somee.com/api/Posts';

    print(storieImage);
    FormData formData = FormData.fromMap({
      // 'Poster': test,
      'UserId': '59210368-afc4-452f-b76b-472996595325',
      'description': 'jojo',
    });
    emit(CreatePostLodingState());
    await dio
        .post(
      url,
      data: formData,
      options: Options(headers: {
        // 'Content-Type': 'text/plail; charset=utf-8',
        // 'lang': lang,
        'Authorization': 'Bearer $token',
      }),
    )
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((onError) {
      print(onError.response.data);
      emit(CreatePostErrorState());
    });
  }

  Future<void> uploadImage2({
    required File imageFile,
    required String userid,
    required String post,
  }) async {
    final url = Uri.parse('http://www.ma511.somee.com/api/Posts');
    final request = http.MultipartRequest('POST', url);
    final dio = Dio();
    final fileStream = http.ByteStream(imageFile.openRead());
    final fileLength = await imageFile.length();
    final file = await http.MultipartFile.fromPath('image', imageFile.path);
    final multipartFile = http.MultipartFile(
      'image',
      fileStream,
      fileLength,
      filename: 'image.jpg',
    );

    request.files.add(multipartFile);

    final response = await request.send();
    final responseData = await response.stream.toBytes();
    print(file);
    FormData formData = FormData.fromMap({
      'Poster': file,
      'UserId': userId,
      'description': post,
    });
    emit(CreatePostLodingState());
    await dio
        .post(
      'http://www.ma511.somee.com/api/Posts',
      data: formData,
      options: Options(headers: {
        'Content-Type': 'multipart/form-data; boundary=something',
        // 'lang': lang,
        'Authorization': 'Bearer $token',
      }),
    )
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(CreatePostErrorState());
    });
    // final responseString = String.fromCharCodes(responseData);
    // final jsonResponse = json.decode(responseString);

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      // print('Failed to upload image. Error: ${jsonResponse['error']}');
    }
  }

  void createPost({
    required String userId,
    String? post,
    File? imageFile,
  }) async {
    emit(CreatePostLodingState());

    const url = 'http://www.ma511.somee.com/api/Posts';
    var im = await MultipartFile.fromFile(imageFile!.path,
        filename: postImage.toString());
    await http.post(
      Uri.parse(url),
      headers: {
        // 'Content-Type': 'multipart/form-data',
        // 'Content-Type': 'multipart/form-data; boundary=something',
        // 'Content-Type': 'application/json',
        'Content-Type': 'application/json',
        // 'lang': lang,
        'Authorization': 'Bearer $token',
      },
      body: {
        'UserId': userId,
        'description': post,
        // 'Poster': imageFile.toString(),
      },
    ).then((value) {
      print("postImage");
      print(postImage.toString());
      //   //CModel commentModel = CModel.fromJson(value.data);
      emit(CreatePostSuccessState());
    }).catchError((error) {
      print(error);
      emit(CreatePostErrorState());
    });
  }

  void deletePost({required String postId}) {
    emit(DeletePostLodingState());

    DioHelper.deleteData(
      url: 'Posts/$postId',
      token: 'Bearer $token',
    ).then((value) {
      emit(DeletePostSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(DeletePostErrorState());
    });
  }

  void deleteComment({required String commentId}) {
    emit(DeleteCommentLodingState());
    DioHelper.deleteData(
      url: 'Posts/comment/$commentId',
      token: 'Bearer $token',
    ).then((value) {
      emit(DeleteCommentSuccessState());
    }).catchError((error) {
      print(error.response.toString());
      emit(DeleteCommentErrorState());
    });
  }

  ProfileModel? profileModel;
  ProfileModel? profileMode;
  List<Post> profilePost = [];
  String bioo = ' ';

  void getProfile() {
    emit(GetProfileLodingState());
    DioHelper.getData(
      url: 'AccountAccess/profile/$userId',
      token: 'Bearer $token',
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      profileModel!.data!.posts!.forEach((Element) {
        profilePost.add(Element);
      });
      print(profileModel!.data!.bio);
      if (profileModel!.data!.bio != null) {
        bioo = profileModel!.data!.bio!;
      }

      // print('uId:');
      // print(name);
      // print(userId);

      // print(postModel[0].postId.toString());
      // print(postModel[0].poster);

      // for (var element in postModel) {
      //   postModel.add(PostModel.fromJson(element));
      // }
      // print('profile');
      // print(profileModel);
      // print(profileModel!.data!.profilepicture);

      // print(profileModel!.data!.posts![0].poster);
      // print(profileModel!.data!.posts!.length);
      print('loooooooooooolo');
      emit(GetProfileSuccessState());
    }).catchError((error) {
      print('>>>>>>>>>>77');
      print(error.toString());
      emit(GetProfileErrorState());
    });
  }

  void getProfilem() {
    emit(GetProfileLodingState());
    DioHelper.getData(
      url: 'AccountAccess/profile/$userId',
      token: 'Bearer $token',
    ).then((value) {
      profileMode = ProfileModel.fromJson(value.data);
      profileMode!.data!.posts!.forEach((Element) {
        profilePost.add(Element);
      });
      print('uId:');
      print(name);
      print(userId);

      // print(postModel[0].postId.toString());
      // print(postModel[0].poster);

      // for (var element in postModel) {
      //   postModel.add(PostModel.fromJson(element));
      // }
      // print('profile');
      // print(profileModel);
      // print(profileModel!.data!.profilepicture);

      // print(profileModel!.data!.posts![0].poster);
      // print(profileModel!.data!.posts!.length);
      print('loooooooooooolo');
      emit(GetProfileSuccessState());
    }).catchError((error) {
      print('>>>>>>>>>>77');
      print(error.toString());
      emit(GetProfileErrorState());
    });
  }

  void getPersonProfile({required String ud}) {
    emit(GetProfileLodingState());
    DioHelper.getData(
      url: 'AccountAccess/profile/$ud',
      token: 'Bearer $token',
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      profileModel!.data!.posts!.forEach((Element) {
        profilePost.add(Element);
      });

      // print(postModel[0].postId.toString());
      // print(postModel[0].poster);

      // for (var element in postModel) {
      //   postModel.add(PostModel.fromJson(element));
      // }
      print('profile');
      print(profileModel);
      print(profileModel!.data!.profilepicture);

      print(profileModel!.data!.posts![0].poster);
      print(profileModel!.data!.posts!.length);

      emit(GetProfileSuccessState());
    }).catchError((error) {
      print('>>>>>>>>>>77');
      print(error.toString());
      emit(GetProfileErrorState());
    });
  }

  up(File? file, String? text, context) async {
    if (file != null) {
      dio.MultipartFile test = await dio.MultipartFile.fromFile(file.path,
          contentType: MediaType('image', 'png'));
      FormData formData = FormData.fromMap(
        {
          "Poster": test,
          "UserId": userId,
          "description": text.toString().isEmpty ? " " : text
        },
      );
      emit(CreatePostLodingState());
      await Dio()
          .post("http://www.ma511.somee.com/api/Posts",
              data: formData,
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ))
          .then((value) {
        print(value.statusCode);
        navigateAndFinish(context, PostScreen());
        emit(CreatePostSuccessState());
      }).catchError((onError) {
        print(onError);
        emit(CreatePostErrorState());
      });
    } else {
      FormData formData = FormData.fromMap(
        {"UserId": userId, "description": text},
      );
      emit(CreatePostLodingState());
      await Dio()
          .post("http://www.ma511.somee.com/api/Posts",
              data: formData,
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ))
          .then((value) {
        print(value.statusCode);
        navigateAndFinish(context, PostScreen());
        emit(CreatePostSuccessState());
      }).catchError((onError) {
        print(onError);
        emit(CreatePostErrorState());
      });
    }
  }

  updateProfileImage(
    File? file,
  ) async {
    dio.MultipartFile test = await dio.MultipartFile.fromFile(file!.path,
        contentType: MediaType('image', 'png'));
    FormData formData = FormData.fromMap(
      {
        "file": test,
      },
    );
    await Dio()
        .put("http://www.ma511.somee.com/api/ProfileSetting/uploadProfilePic",
            data: formData,
            options: Options(
              headers: {'Authorization': 'Bearer $token'},
            ))
        .then((value) {
      print(profilImage);
      emit(UpdateImageprofileSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(UpdateImageprofileErrorState());
    });
  }

  updateCoverImage(
    File? file,
  ) async {
    dio.MultipartFile test = await dio.MultipartFile.fromFile(file!.path,
        contentType: MediaType('image', 'png'));
    FormData formData = FormData.fromMap(
      {
        "file": test,
      },
    );
    await Dio()
        .put("http://www.ma511.somee.com/api/ProfileSetting/uploadCoverPic",
            data: formData,
            options: Options(
              headers: {'Authorization': 'Bearer $token'},
            ))
        .then((value) {
      print(profilImage);
      emit(UpdateImageCoverSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(UpdateImageCoverErrorState());
    });
  }

  List<dynamic> li = [];
  List<PostModel> postM = [];
  List<bool> seli = [];
  bool isLike = false;
  IconData iconLike = Icons.favorite_outline;
  void like() {
    isLike = !isLike;
    iconLike = isLike ? iconData = Icons.favorite : Icons.favorite_outline;

    emit(LikeSuccessState());
  }

  void li1(String postId) {
    // if (islike) {
    DioHelper.postData(
        url: 'Posts/like',
        token: 'Bearer $token',
        data: {"userId": userId, "postId": postId}).then((value) {
      print(li[0]);
      print(li[1]);
      li.forEach((element) {
        seli.add(false);
      });
      emit(LikePostSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(LikePostErrorState());
    });
  }

  void li2(String likeId, String postId, index) {
    DioHelper.deleteData(
      url: 'Posts/like/$likeId',
      token: 'Bearer $token',
    ).then((value) {
      li.remove(postModel[index].postId);
      emit(DeleteLikePostSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(DeleteLikePostErrorState());
    });
  }

  void getPr() {
    emit(GetProfileLodingState());
    DioHelper.getData(
      url: 'AccountAccess/profile/4cbfc705-a5da-4895-a82d-ec56b50abb78',
      token:
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0Y2JmYzcwNS1hNWRhLTQ4OTUtYTgyZC1lYzU2YjUwYWJiNzgiLCJqdGkiOiJhODk2ZGRmYS0wNjAzLTRmOTMtYTAwNC05MDZlYTRjNzdjYTUiLCJlbWFpbCI6Im11c2EuYWxhYWxkZWVuNzdAZ21haWwuY29tIiwiVXNlck5hbWUiOiIwNzg4NzQwNDk5Iiwicm9sZXMiOiJVc2VyIiwiZXhwIjoxNjg2NTY3OTQwLCJpc3MiOiJTZXJ2ZXIiLCJhdWQiOiJDbGllbiBTaWRlIn0.nOH13GTbb8OjJcoKDILPMCtKkbrszmBYQVaVXP_1i10',
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      profileModel!.data!.posts!.forEach((Element) {
        profilePost.add(Element);
      });

      // print(postModel[0].postId.toString());
      // print(postModel[0].poster);

      // for (var element in postModel) {
      //   postModel.add(PostModel.fromJson(element));
      // }
      // print('profile');
      // print(profileModel);
      // print(profileModel!.data!.profilepicture);

      // print(profileModel!.data!.posts![0].poster);
      // print(profileModel!.data!.posts!.length);
      print('lllllllolllllllo');
      emit(GetProfileSuccessState());
    }).catchError((error) {
      print('>>>>>>>>>>77');
      print(error.toString());
      emit(GetProfileErrorState());
    });
  }
}
