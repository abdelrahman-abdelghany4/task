import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/shared/cubit/states.dart';
import 'package:task/shared/remote/cash_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool? isArabic = true;

  void changeAppLang({bool? fromShared}) {
    if (fromShared != null) {
      isArabic = fromShared;
      emit(AppChangeLanguageState());
    } else {
      isArabic = !isArabic!;
      CacheHelper.saveData(key: 'isArabic', value: isArabic!).then((value) {
        emit(AppChangeLanguageState());
      });
    }
  }
}
