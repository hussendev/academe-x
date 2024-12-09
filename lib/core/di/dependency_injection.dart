import 'package:academe_x/features/college_major/data/data.dart';
import 'package:academe_x/features/features.dart';
import 'package:academe_x/features/home/domain/usecases/get_tags_use_case.dart';
import 'package:academe_x/features/college_major/controller/cubit/get_tags_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/show_tag_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/tag_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/create_post/get_tags_state.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../features/college_major/controller/cubit/college_major_cubit.dart';
import '../../features/college_major/domain/repositories/college_major_repository.dart';
import '../../features/college_major/domain/usecases/college_major_use_case.dart';
import '../../features/home/data/repositories/create_post_repository_imp.dart';
import '../../features/home/domain/usecases/create_post_use_case.dart';
import '../../features/home/presentation/controllers/cubits/create_post/create_post_cubit.dart';
import '../../features/home/presentation/controllers/cubits/post/posts_cubit.dart';
import '../core.dart';
// import '../services/hive_cache_manager.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
  // Cubits
  _initCubits();

  // State
  _initState();

  // Use Cases
  _initUseCases();

  // Repositories
  _initRepositories();

  // Data Sources
  _initDataSources();

  // External Dependencies
  await _initExternalDependencies();
}

void _initCubits() {

  getIt.registerFactory<LoginCubit>(() => LoginCubit(authUseCase: getIt()));

  getIt.registerFactory<CreatePostCubit>(
    () => CreatePostCubit(InitialState(), createPostUseCase: getIt()),
  );

  getIt.registerFactory<GetTagsCubit>(
    () => GetTagsCubit(getTagsUseCase: getIt()),
  );

  getIt.registerFactory<AuthActionCubit>(
    () => AuthActionCubit(false),
  );

  getIt.registerFactory<PostsCubit>(
    () => PostsCubit(postUseCase: getIt()),
  );

  getIt.registerFactory<BottomNavCubit>(
    () => BottomNavCubit(),
  );

  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );

  getIt.registerFactory<PickerCubit>(
    () => PickerCubit(CreatePostIconsInit()),
  );
  getIt.registerFactory<TagCubit>(
    () => TagCubit(InitTagState()),
  );
  getIt.registerFactory<ShowTagCubit>(
    () => ShowTagCubit(false),
  );
  getIt.registerFactory<ConnectivityCubit>(
    () => ConnectivityCubit(),
  );

  getIt.registerFactory<PostImageCubit>(
    () => PostImageCubit(),
  );
  getIt.registerFactory<SignupCubit>(
    () => SignupCubit(
      authUseCase: getIt(),
    ),
  );

  getIt.registerFactory<CollegeCubit>(
    () => CollegeCubit(),
  );
  getIt.registerFactory<CollegeMajorsCubit>(
    () => CollegeMajorsCubit(cacheManager: getIt(), getMajorsUseCase: getIt()),
  );

}

void _initState() {
  getIt.registerLazySingleton<FilePickerLoaded>(
        ()=>FilePickerLoaded(null),
  );
  getIt.registerLazySingleton<ImagePickerLoaded>(
        ()=>ImagePickerLoaded(null),
  );
  getIt.registerLazySingleton<SuccessTagState>(
      ()=>SuccessTagState(selectedTags: []),
  );
}

void _initUseCases() {
  getIt.registerLazySingleton<AuthenticationUseCase>(
    () => AuthenticationUseCase(authenticationRepository: getIt()),
  );
  getIt.registerLazySingleton<CreatePostUseCase>(
    () => CreatePostUseCase(createPostRepository: getIt()),
  );
  getIt.registerLazySingleton<PostUseCase>(
    () => PostUseCase(postRepository: getIt()),
  );

  getIt.registerLazySingleton<GetTagsUseCase>(
    () => GetTagsUseCase(createPostRepository: getIt()),
  );
  getIt.registerLazySingleton<CollegeMajorUseCase>(
    () => CollegeMajorUseCase(collegeMajorRepository: getIt()),
  );
}

void _initRepositories() {
  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
        remoteDataSource: getIt(),
        cacheManager: getIt(),
        networkInfo: InternetConnectionChecker()),
  );
  getIt.registerLazySingleton<CreatePostRepository>(
    () => CreatePostRepositoryImp(createPostRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(remoteDataSource: getIt(), cacheManager: getIt(),createPostRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<CollegeMajorRepository>(
    () => CollegeMajorRepositoryImpl(remoteDataSource: getIt(), cacheManager: getIt(), networkInfo: getIt()),
  );
}

void _initDataSources() {
  getIt.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
      // cacheManager: getIt(),
    ),
  );

  getIt.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
      // cacheManager: getIt(),
    ),
  );

  getIt.registerLazySingleton<CreatePostRemoteDataSource>(
    () => CreatePostRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );
  getIt.registerLazySingleton<CollegeMajorRemoteDataSource>(
    () => CollegeMajorRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );
}

Future<void> _initExternalDependencies() async {
  final cacheManager = HiveCacheManager();
  await cacheManager.init();
  getIt.registerLazySingleton(() => cacheManager);
  getIt.registerLazySingleton(() => ApiController());
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
