import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ml_model/extension.dart';
import 'package:ml_model/models/classify_model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  final ImagePicker _picker = ImagePicker();
  File? image;
  String? model;

  Future loadModel() async {
    try {
      model = await Tflite.loadModel(
        model: "assets/model/model.tflite",
        labels: "assets/model/labels.txt",
      );
      log('Model status: $model');
    } catch (e) {
      log('$e');
    }
  }

 ClassifyModel? classifyModel;

  Future classifyImage(image) async {
    try {
      var output = await Tflite.runModelOnImage(
        path: image,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      classifyModel = ClassifyModel.fromMap(output!.first);
      log(classifyModel!.label.getLabel());
    } catch (e) {
      log('$e');
    }
  }

  void closeImage(){
    image = null;
    classifyModel = null;
    emit(HomeInitial());
  }

  Future<void> getImage() async {
    emit(HomeLoadingResult());
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      await classifyImage(image!.path);
      emit(HomeLoadedResult());
    } else{
      emit(HomeLoadedResult());
    }
  }
}
