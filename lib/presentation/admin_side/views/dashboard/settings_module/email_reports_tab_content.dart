import 'package:flutter/material.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/widgets/enable_disable_button_row_widget.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/providers/settings_provider.dart';
import 'package:time_tracker/services/database_services.dart';
import 'package:time_tracker/widgets/custom_loading.dart';
import 'package:time_tracker/widgets/global_divider_widget.dart';

class EmailReportsContentTab extends StatelessWidget {
  EmailReportsContentTab({
    super.key,
    required this.settingsProvider,
  });
  final SettingsProvider settingsProvider;
  final DatabaseServices databaseServices = DatabaseServices();
  final String streamDocName = 'email_reports';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: databaseServices.settingsStream(streamDocName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data.data();
              return EnableDisableButtonRowWidget(
                text: AppTexts.receiveWeeklyReports,
                showDefaultButton: false,
                checkWith: data?['weeklyTrackingReport'],
                onDisableTap: () =>
                    updatebuttonState({'weeklyTrackingReport': 'disable'}),
                onEnableTap: () =>
                    updatebuttonState({'weeklyTrackingReport': 'enable'}),
              );
            }
            return showWaveLoading();
          },
        ),
        const SizedBox(height: 20),
        StreamBuilder(
          stream: databaseServices.settingsStream(streamDocName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data.data();
              return EnableDisableButtonRowWidget(
                text: AppTexts.receiveDailyReports,
                showDefaultButton: false,
                checkWith: data?['dailyTrackingReport'],
                onDisableTap: () =>
                    updatebuttonState({'dailyTrackingReport': 'disable'}),
                onEnableTap: () =>
                    updatebuttonState({'dailyTrackingReport': 'enable'}),
              );
            }
            return showWaveLoading();
          },
        ),
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 35),
            child: GlobalDividerWidget(
              dividerColor: AppColors.appDarkGrey,
              width: double.infinity,
            )),
        StreamBuilder(
          stream: databaseServices.settingsStream(streamDocName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data.data();
              return EnableDisableButtonRowWidget(
                text: AppTexts.sendDailyWarningEmails,
                defaultButtonText: AppTexts.disable,
                showDefaultButton: true,
                checkWith: data?['dailyWarningEmail'],
                onDisableTap: () =>
                    updatebuttonState({'dailyWarningEmail': 'disable'}),
                onEnableTap: () =>
                    updatebuttonState({'dailyWarningEmail': 'enable'}),
                onDefaultTap: () =>
                    updatebuttonState({'dailyWarningEmail': 'disable'}),
              );
            }
            return showWaveLoading();
          },
        ),
        const SizedBox(height: 20),
        StreamBuilder(
          stream: databaseServices.settingsStream(streamDocName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data.data();
              return EnableDisableButtonRowWidget(
                text: AppTexts.sendWeeklyWarningEmails,
                defaultButtonText: AppTexts.disable,
                showDefaultButton: true,
                checkWith: data?['weeklyWarningEmail'],
                onDisableTap: () =>
                    updatebuttonState({'weeklyWarningEmail': 'disable'}),
                onEnableTap: () =>
                    updatebuttonState({'weeklyWarningEmail': 'enable'}),
                onDefaultTap: () =>
                    updatebuttonState({'weeklyWarningEmail': 'disable'}),
              );
            }
            return showWaveLoading();
          },
        ),
        const SizedBox(height: 20),
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
