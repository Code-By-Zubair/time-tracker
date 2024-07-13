import 'package:flutter/material.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/widgets/enable_disable_button_row_widget.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/services/database_services.dart';
import 'package:time_tracker/widgets/custom_loading.dart';

class AccessToReportsTabContent extends StatelessWidget {
  AccessToReportsTabContent({
    super.key,
  });
  final DatabaseServices databaseServices = DatabaseServices();
  final String streamDocName = 'access_to_reports';
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
                text: AppTexts.usersCanSeeReports,
                showDefaultButton: false,
                checkWith: data?['userSeeReports'],
                onDisableTap: () =>
                    updatebuttonState({'userSeeReports': 'disable'}),
                onEnableTap: () =>
                    updatebuttonState({'userSeeReports': 'enable'}),
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
                text: AppTexts.usersCanSeeSS,
                showDefaultButton: false,
                checkWith: data?['userSeeSS'],
                onDisableTap: () => updatebuttonState({'userSeeSS': 'disable'}),
                onEnableTap: () => updatebuttonState({'userSeeSS': 'enable'}),
              );
            }
            return showWaveLoading();
          },
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
