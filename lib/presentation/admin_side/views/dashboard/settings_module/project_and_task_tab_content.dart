import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/providers/settings_provider.dart';
import 'package:time_tracker/services/database_services.dart';
import 'package:time_tracker/widgets/custom_loading.dart';
import 'package:time_tracker/widgets/global_divider_widget.dart';
import 'package:time_tracker/widgets/global_switch_button_widget.dart';

class ProjectAndTaskContentTab extends StatelessWidget {
  ProjectAndTaskContentTab({
    super.key,
  });

  final DatabaseServices databaseServices = DatabaseServices();
  final String projectStream = 'projects';
  final String sprintsStream = 'sprints';
  final String taskStream = 'tasks';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ElevatedButton(
        //     child: const Text('save'),
        //     onPressed: () async {
        //       databaseServices.saveScreenCaptureSettings();
        //     }),
        // const Text(
        //   AppTexts.emailNotifications,
        //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        // ),
        // Row(
        //   children: [
        //     GlobalSwitchButton(
        //       currentState:
        //           settingsProvider.sendEmailNotificationToUSerWhenTaskAssigned,
        //       onTap: (value) {
        //         Provider.of<SettingsProvider>(context, listen: false)
        //             .sendEmailNotificationToUSerWhenTaskAssignedFunc(value);
        //       },
        //     ),
        //     const Text(
        //       AppTexts.sendEmailNotificationToUSerWhenTaskAssigned,
        //       style: TextStyle(
        //           fontSize: 16,
        //           fontWeight: FontWeight.w400,
        //           color: AppColors.appDarkGrey),
        //     )
        //   ],
        // ),
        // const Padding(
        //   padding: EdgeInsets.only(top: 20, bottom: 30),
        //   child: GlobalDividerWidget(
        //     dividerColor: AppColors.appDarkGrey,
        //     width: double.infinity,
        //   ),
        // ),
        const Text(
          AppTexts.projects,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppTexts.canCreateProject,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream: databaseServices
                        .projectsTaskSettingsStream(projectStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();

                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                projectStream, {'managerCreate': value}),
                            currentState: data?['managerCreate']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.manager,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream: databaseServices
                        .projectsTaskSettingsStream(projectStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();
                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                projectStream, {'userCreate': value}),
                            currentState: data?['userCreate']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.user,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppTexts.canUpdateProject,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream: databaseServices
                        .projectsTaskSettingsStream(projectStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();
                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                projectStream, {'managerUpdate': value}),
                            currentState: data?['managerUpdate']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.manager,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream: databaseServices
                        .projectsTaskSettingsStream(projectStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();
                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                projectStream, {'userUpdate': value}),
                            currentState: data?['userUpdate']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.user,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppTexts.canDeleteProject,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream: databaseServices
                        .projectsTaskSettingsStream(projectStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();
                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                projectStream, {'managerDelete': value}),
                            currentState: data?['managerDelete']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.manager,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream: databaseServices
                        .projectsTaskSettingsStream(projectStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();
                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                projectStream, {'userDelete': value}),
                            currentState: data?['userDelete']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.user,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 30),
          child: GlobalDividerWidget(
            dividerColor: AppColors.appDarkGrey,
            width: double.infinity,
          ),
        ),
        const Text(
          AppTexts.sprints,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppTexts.canCreateSprints,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream: databaseServices
                        .projectsTaskSettingsStream(sprintsStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();

                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                sprintsStream, {'managerCreate': value}),
                            currentState: data?['managerCreate']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.manager,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream: databaseServices
                        .projectsTaskSettingsStream(sprintsStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();

                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                sprintsStream, {'userCreate': value}),
                            currentState: data?['userCreate']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.user,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppTexts.canUpdateSprints,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream: databaseServices
                        .projectsTaskSettingsStream(sprintsStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();

                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                sprintsStream, {'managerUpdate': value}),
                            currentState: data?['managerUpdate']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.manager,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream: databaseServices
                        .projectsTaskSettingsStream(sprintsStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();

                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                sprintsStream, {'userUpdate': value}),
                            currentState: data?['userUpdate']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.user,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppTexts.canDeleteSprints,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream: databaseServices
                        .projectsTaskSettingsStream(sprintsStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();

                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                sprintsStream, {'managerDelete': value}),
                            currentState: data?['managerDelete']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.manager,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream: databaseServices
                        .projectsTaskSettingsStream(sprintsStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();

                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                sprintsStream, {'userDelete': value}),
                            currentState: data?['userDelete']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.user,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 30),
          child: GlobalDividerWidget(
            dividerColor: AppColors.appDarkGrey,
            width: double.infinity,
          ),
        ),
        const Text(
          AppTexts.tasks,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppTexts.canCreateTasks,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream:
                        databaseServices.projectsTaskSettingsStream(taskStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();

                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                taskStream, {'managerCreate': value}),
                            currentState: data?['managerCreate']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.manager,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream:
                        databaseServices.projectsTaskSettingsStream(taskStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();

                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                taskStream, {'userCreate': value}),
                            currentState: data?['userCreate']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.user,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Can update tasks',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream:
                        databaseServices.projectsTaskSettingsStream(taskStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();

                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                taskStream, {'managerUpdate': value}),
                            currentState: data?['managerUpdate']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.manager,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream:
                        databaseServices.projectsTaskSettingsStream(taskStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();

                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                taskStream, {'userUpdate': value}),
                            currentState: data?['userUpdate']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.user,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'can delete tasks',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream:
                        databaseServices.projectsTaskSettingsStream(taskStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();

                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                taskStream, {'managerDelete': value}),
                            currentState: data?['managerDelete']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.manager,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(
                children: [
                  StreamBuilder(
                    stream:
                        databaseServices.projectsTaskSettingsStream(taskStream),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data.data();

                        return GlobalSwitchButton(
                            onTap: (value) => updatebuttonState(
                                taskStream, {'userDelete': value}),
                            currentState: data?['userDelete']);
                      }
                      return showWaveLoading();
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    AppTexts.user,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
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

  updatebuttonState(
    String streamName,
    Map<String, dynamic> data,
  ) {
    databaseServices.updateProjectTaskSettings(streamName, data);
  }
}
