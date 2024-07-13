import 'package:flutter/material.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/widgets/enable_disable_button_row_widget.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/services/database_services.dart';
import 'package:time_tracker/widgets/custom_loading.dart';

class ManualTimeContentTab extends StatelessWidget {
  ManualTimeContentTab({
    super.key,
  });
  final DatabaseServices databaseServices = DatabaseServices();
  final String streamDocName = 'mannual_time';

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
                text: AppTexts.allowUserToSubmitAManualTime,
                showDefaultButton: false,
                checkWith: data?['userSubmitTime'],
                onDisableTap: () =>
                    updatebuttonState({'userSubmitTime': 'disable'}),
                onEnableTap: () =>
                    updatebuttonState({'userSubmitTime': 'enable'}),
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
                text: AppTexts.manualTimeHasToBeApproved,
                showDefaultButton: false,
                checkWith: data?['timeApproveBeforeApplied'],
                onDisableTap: () =>
                    updatebuttonState({'timeApproveBeforeApplied': 'disable'}),
                onEnableTap: () =>
                    updatebuttonState({'timeApproveBeforeApplied': 'enable'}),
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
                text: AppTexts.managerCanApprove,
                showDefaultButton: false,
                checkWith: data?['managerReceiveTimeRequest'],
                onDisableTap: () =>
                    updatebuttonState({'managerReceiveTimeRequest': 'disable'}),
                onEnableTap: () =>
                    updatebuttonState({'managerReceiveTimeRequest': 'enable'}),
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
                text: AppTexts.adminsAlwaysReceiveManual,
                showDefaultButton: false,
                checkWith: data?['adminAlwaysReceiveTimeRequest'],
                onDisableTap: () => updatebuttonState(
                    {'adminAlwaysReceiveTimeRequest': 'disable'}),
                onEnableTap: () => updatebuttonState(
                    {'adminAlwaysReceiveTimeRequest': 'enable'}),
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
