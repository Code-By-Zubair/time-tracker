import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/widgets/enable_disable_button_row_widget.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/providers/settings_provider.dart';
import 'package:time_tracker/services/database_services.dart';
import 'package:time_tracker/widgets/custom_loading.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

// ignore: must_be_immutable
class ScreenCaptureTabContent extends StatelessWidget {
  ScreenCaptureTabContent({
    super.key,
    
  });
 
  final DatabaseServices databaseServices = DatabaseServices();
  final String streamDocName = 'screenCapture_settings';
  TextEditingController ssIntervalCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        StreamBuilder(
          stream: databaseServices.settingsStream(streamDocName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data.data();
              return EnableDisableButtonRowWidget(
                text: AppTexts.takeSSWhileTrackingEnable,
                showDefaultButton: false,
                checkWith: data?['takeSSTracEnable'],
                onDisableTap: () =>
                    updatebuttonState({'takeSSTracEnable': 'disable'}),
                onEnableTap: () =>
                    updatebuttonState({'takeSSTracEnable': 'enable'}),
              );
            }
            return showWaveLoading();
          },
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                AppTexts.ssInterval,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: databaseServices.settingsStream(streamDocName),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data.data();
                    ssIntervalCont.text = data?['ssInterval'];
                    return Row(
                      children: [
                        SizedBox(
                          height: 35,
                          width: 150,
                          child: RoundedTextField(
                              textController: ssIntervalCont,
                              hintText: 'Minutes',
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              enableBorder: true,
                              borderColor: AppColors.appLightGrey,
                              textFieldColor: Colors.white,
                              keyboardType: TextInputType.text,
                              obscureText: false),
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: 70,
                          height: 32,
                          child: GlobalTextButton(
                              bachgroundColor: AppColors.appPrimaryColor,
                              buttonTextColor: Colors.white,
                              text: AppTexts.save,
                              onTap: () => updatebuttonState(
                                  {'ssInterval': ssIntervalCont.text.trim()})),
                        ),
                      ],
                    );
                  }
                  return showWaveLoading();
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        StreamBuilder(
          stream: databaseServices.settingsStream(streamDocName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data.data();
              return EnableDisableButtonRowWidget(
                text: AppTexts.randomizeSSInterval,
                showDefaultButton: false,
                checkWith: data?['randomizeSSInterval'],
                onDisableTap: () =>
                    updatebuttonState({'randomizeSSInterval': 'disable'}),
                onEnableTap: () =>
                    updatebuttonState({'randomizeSSInterval': 'enable'}),
              );
            }
            return showWaveLoading();
          },
        ),
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                AppTexts.blurSSBeforeUploadingToCloud,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: databaseServices.settingsStream(streamDocName),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data.data();
                    return Wrap(
                      runSpacing: 15,
                      children: [
                        SizedBox(
                          child: GlobalTextButton(
                            bachgroundColor: data?['blurSS'] == 'disable'
                                ? AppColors.appPrimaryColor
                                : Colors.white,
                            buttonTextColor: data?['blurSS'] == 'disable'
                                ? Colors.white
                                : Colors.black,
                            borderColor: data?['blurSS'] == 'disable'
                                ? AppColors.appPrimaryColor
                                : AppColors.appDarkGrey,
                            text: AppTexts.disableBlurring,
                            onTap: () =>
                                updatebuttonState({'blurSS': 'disable'}),
                          ),
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          child: GlobalTextButton(
                            bachgroundColor: data?['blurSS'] == 'slightly'
                                ? AppColors.appPrimaryColor
                                : Colors.white,
                            buttonTextColor: data?['blurSS'] == 'slightly'
                                ? Colors.white
                                : Colors.black,
                            borderColor: data?['blurSS'] == 'slightly'
                                ? AppColors.appPrimaryColor
                                : AppColors.appDarkGrey,
                            text: AppTexts.slightlyBlur,
                            onTap: () =>
                                updatebuttonState({'blurSS': 'slightly'}),
                          ),
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          child: GlobalTextButton(
                            bachgroundColor: data?['blurSS'] == 'maximum'
                                ? AppColors.appPrimaryColor
                                : Colors.white,
                            buttonTextColor: data?['blurSS'] == 'maximum'
                                ? Colors.white
                                : Colors.black,
                            borderColor: data?['blurSS'] == 'maximum'
                                ? AppColors.appPrimaryColor
                                : AppColors.appDarkGrey,
                            text: AppTexts.maximumBlurring,
                            onTap: () =>
                                updatebuttonState({'blurSS': 'maximum'}),
                          ),
                        ),
                      ],
                    );
                  }
                  return showWaveLoading();
                },
              ),
            )
          ],
        ),
      ],
    );
  }

  WaveLoadingWidget showWaveLoading() {
    return const WaveLoadingWidget(
      color: Colors.orange,
    );
  }

  updatebuttonState(Map<String, dynamic> data) {
    databaseServices.updateSetting(data, streamDocName);
  }
}
