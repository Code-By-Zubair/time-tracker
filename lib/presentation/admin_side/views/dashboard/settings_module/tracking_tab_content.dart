import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/widgets/enable_disable_button_row_widget.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/services/database_services.dart';
import 'package:time_tracker/widgets/custom_loading.dart';
import 'package:time_tracker/widgets/global_divider_widget.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

// ignore: must_be_immutable
class TrackingTabContent extends StatelessWidget {
  TrackingTabContent({
    super.key,
  });
  final DatabaseServices databaseServices = DatabaseServices();
  TextEditingController trackingTimecont = TextEditingController();
  final String streamDocName = 'tracking_settings';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: StreamBuilder(
            stream: databaseServices.settingsStream(streamDocName),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data?.data();
                return EnableDisableButtonRowWidget(
                  text: AppTexts.automaticMode,
                  showDefaultButton: false,
                  checkWith: data?['automaticMode'],
                  onDisableTap: () =>
                      updatebuttonState({'automaticMode': 'disable'}),
                  onEnableTap: () =>
                      updatebuttonState({'automaticMode': 'enable'}),
                );
              }

              return showWaveLoading();
            },
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          child: StreamBuilder(
            stream: databaseServices.settingsStream(streamDocName),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data?.data();
                return EnableDisableButtonRowWidget(
                  text: AppTexts.stealthMode,
                  showDefaultButton: false,
                  checkWith: data?['stealthMode'],
                  onDisableTap: () =>
                      updatebuttonState({'stealthMode': 'disable'}),
                  onEnableTap: () =>
                      updatebuttonState({'stealthMode': 'enable'}),
                );
              }
              return showWaveLoading();
            },
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          // width: 640,
          child: StreamBuilder(
            stream: databaseServices.settingsStream(streamDocName),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data?.data();
                return EnableDisableButtonRowWidget(
                  text: AppTexts.extendedStealthMode,
                  showDefaultButton: false,
                  checkWith: data?['extendedStealthMode'],
                  onDisableTap: () =>
                      updatebuttonState({'extendedStealthMode': 'disable'}),
                  onEnableTap: () =>
                      updatebuttonState({'extendedStealthMode': 'enable'}),
                );
              }
              return showWaveLoading();
            },
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          // width: 640,
          child: StreamBuilder(
            stream: databaseServices.settingsStream(streamDocName),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data?.data();
                return EnableDisableButtonRowWidget(
                  text: AppTexts.stopTrackingIfIdle,
                  showDefaultButton: false,
                  checkWith: data?['stopTrackingIdle'],
                  onDisableTap: () =>
                      updatebuttonState({'stopTrackingIdle': 'disable'}),
                  onEnableTap: () =>
                      updatebuttonState({'stopTrackingIdle': 'enable'}),
                );
              }
              return showWaveLoading();
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                AppTexts.stopTrackingIdIdleXMinutes,
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
                    var data = snapshot.data?.data();
                    trackingTimecont.text = data?['trackingXminutes'];
                    return Row(
                      children: [
                        SizedBox(
                          height: 35,
                          width: 150,
                          child: RoundedTextField(
                              textController: trackingTimecont,
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
                            onTap: () {
                              updatebuttonState({
                                'trackingXminutes': trackingTimecont.text.trim()
                              });
                            },
                          ),
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
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: GlobalDividerWidget(
            width: double.infinity,
            dividerColor: AppColors.appDarkGrey,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          // width: 640,
          child: StreamBuilder(
            stream: databaseServices.settingsStream(streamDocName),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data.data();
                return EnableDisableButtonRowWidget(
                  text: AppTexts.allowWorkAwayFromComputer,
                  showDefaultButton: false,
                  checkWith: data?['allowWorkAway'],
                  onDisableTap: () =>
                      updatebuttonState({'allowWorkAway': 'disable'}),
                  onEnableTap: () =>
                      updatebuttonState({'allowWorkAway': 'enable'}),
                );
              }
              return showWaveLoading();
            },
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          // width: 640,
          child: StreamBuilder(
            stream: databaseServices.settingsStream(streamDocName),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data.data();
                return EnableDisableButtonRowWidget(
                  text: AppTexts.startsTrackingWhenComputerStarts,
                  showDefaultButton: false,
                  checkWith: data?['computerStarts'],
                  onDisableTap: () =>
                      updatebuttonState({'computerStarts': 'disable'}),
                  onEnableTap: () =>
                      updatebuttonState({'computerStarts': 'enable'}),
                );
              }
              return showWaveLoading();
            },
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          // width: 640,
          child: StreamBuilder(
            stream: databaseServices.settingsStream(streamDocName),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data.data();
                return EnableDisableButtonRowWidget(
                  text: AppTexts.stopTrackingIfNoInternetConnection,
                  showDefaultButton: false,
                  checkWith: data?['stopTrackingNoInternet'],
                  onDisableTap: () =>
                      updatebuttonState({'stopTrackingNoInternet': 'disable'}),
                  onEnableTap: () =>
                      updatebuttonState({'stopTrackingNoInternet': 'enable'}),
                );
              }
              return showWaveLoading();
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                AppTexts.showIndicator,
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
                              bachgroundColor:
                                  data?['showIndicator'] == 'enable'
                                      ? AppColors.appPrimaryColor
                                      : Colors.white,
                              buttonTextColor:
                                  data?['showIndicator'] == 'enable'
                                      ? Colors.white
                                      : Colors.black,
                              borderColor: data?['showIndicator'] == 'enable'
                                  ? AppColors.appPrimaryColor
                                  : AppColors.appDarkGrey,
                              text: AppTexts.enable,
                              onTap: () => updatebuttonState(
                                  {'showIndicator': 'enable'})),
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          child: GlobalTextButton(
                            bachgroundColor: data?['showIndicator'] == 'disable'
                                ? AppColors.appPrimaryColor
                                : Colors.white,
                            buttonTextColor: data?['showIndicator'] == 'disable'
                                ? Colors.white
                                : Colors.black,
                            borderColor: data?['showIndicator'] == 'disable'
                                ? AppColors.appPrimaryColor
                                : AppColors.appDarkGrey,
                            text: AppTexts.disable,
                            onTap: () =>
                                updatebuttonState({'showIndicator': 'disable'}),
                          ),
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          child: GlobalTextButton(
                            bachgroundColor:
                                data?['showIndicator'] == 'tracking'
                                    ? AppColors.appPrimaryColor
                                    : Colors.white,
                            buttonTextColor:
                                data?['showIndicator'] == 'tracking'
                                    ? Colors.white
                                    : Colors.black,
                            borderColor: data?['showIndicator'] == 'tracking'
                                ? AppColors.appPrimaryColor
                                : AppColors.appDarkGrey,
                            text: AppTexts.whenTracking,
                            onTap: () => updatebuttonState(
                                {'showIndicator': 'tracking'}),
                          ),
                        ),
                        const SizedBox(width: 15),
                        GlobalTextButton(
                            bachgroundColor: Colors.white,
                            borderColor: AppColors.appDarkGrey,
                            text: AppTexts.defaultEnabled,
                            onTap: () {
                              updatebuttonState({'showIndicator': 'enable'});
                            })
                      ],
                    );
                  }
                  return showWaveLoading();
                },
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          // width: 640,
          child: StreamBuilder(
            stream: databaseServices.settingsStream(streamDocName),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data.data();
                return EnableDisableButtonRowWidget(
                  text: AppTexts.trackApplicationUsage,
                  showDefaultButton: false,
                  checkWith: data?['trackApplicationUsage'],
                  onDisableTap: () =>
                      updatebuttonState({'trackApplicationUsage': 'disable'}),
                  onEnableTap: () =>
                      updatebuttonState({'trackApplicationUsage': 'enable'}),
                );
              }
              return showWaveLoading();
            },
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          // width: 640,
          child: StreamBuilder(
            stream: databaseServices.settingsStream(streamDocName),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data.data();
                return EnableDisableButtonRowWidget(
                  text: AppTexts.locationTracking,
                  showDefaultButton: false,
                  checkWith: data?['locationTracking'],
                  onDisableTap: () =>
                      updatebuttonState({'locationTracking': 'disable'}),
                  onEnableTap: () =>
                      updatebuttonState({'locationTracking': 'enable'}),
                );
              }
              return showWaveLoading();
            },
          ),
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
    databaseServices.updateSetting(data,streamDocName);
  }
}
