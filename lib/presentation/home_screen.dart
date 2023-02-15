import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:ml_model/extension.dart';
import 'package:ml_model/presentation/widget/circular_button.dart';
import '../business_logic/home_cubit.dart';

const numClasses = 2;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..loadModel(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: const Text('ML Model'),
                backgroundColor: const Color.fromARGB(215, 2, 141, 216),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (state is! HomeLoadingResult) ...{
                    if (cubit.image != null) ...{
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  cubit.image!,
                                  height: 400,
                                  width: double.maxFinite,
                                  fit: BoxFit.cover,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularButton(
                                onTap: () {
                                  cubit.closeImage();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    } else ...{
                      Lottie.asset('assets/images/robot.json'),
                    },
                  } else ...{
                    const SizedBox(
                      height: 400,
                      child: Center(child: CircularProgressIndicator())),
                  },
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async {
                            await cubit.getImage();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(215, 2, 141, 216),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: const Text('Select Image',style: TextStyle(
                            fontSize: 20,
                          ),),
                        ),
                      ),
                    ),
                  ),
                  if (cubit.classifyModel!=null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:15.0),
                      child: Text(
                        'Result: ${cubit.classifyModel!.label.getLabel()}',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ));
        },
      ),
    );
  }
}
