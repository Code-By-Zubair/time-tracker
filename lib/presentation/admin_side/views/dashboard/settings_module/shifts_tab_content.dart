import 'package:flutter/material.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/widgets/enable_disable_button_row_widget.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/services/database_services.dart';
import 'package:time_tracker/widgets/custom_loading.dart';

class ShiftsTabContent extends StatelessWidget {
  ShiftsTabContent({
    super.key,
  });
  final DatabaseServices databaseServices = DatabaseServices();
  final String streamDocName = 'shifts';

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
                text: AppTexts.shiftingSchedule,
                showDefaultButton: false,
                checkWith: data?['shiftScheduling'],
                onDisableTap: () =>
                    updatebuttonState({'shiftScheduling': 'disable'}),
                onEnableTap: () =>
                    updatebuttonState({'shiftScheduling': 'enable'}),
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
