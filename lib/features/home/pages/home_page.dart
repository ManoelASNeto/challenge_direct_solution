import 'dart:io';

import 'package:challenge_direct_solution/core/utils/app_strings.dart';
import 'package:challenge_direct_solution/features/home/pages/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/gradient_container.dart';
import '../../auth/presentation/cubit/auth_cubit.dart';
import '../../auth/presentation/widgets/logo_custom.dart';
import '../widgets/container_custom.dart';
import '../widgets/drawer_custom.dart';

class HomePage extends StatelessWidget {
  final Uri _url = Uri.parse('https://jsonplaceholder.typicode.com/');
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          final user = state.user;
          final userName = user.name ?? AppStrings.user;
          final userPhoto = user.photoUrl;

          return Scaffold(
            appBar: AppBar(
              title: LogoCustom(),
              centerTitle: true,
              backgroundColor: context.backgroundMedium,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                color: context.backgroundDark,
              ),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 70,
                      maxWidth: double.infinity,
                    ),
                    child: Container(
                      decoration: context.linearGradientBox,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: userPhoto != null
                                  ? NetworkImage(userPhoto)
                                  : const AssetImage('assets/user.jpeg') as ImageProvider,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppStrings.welcome,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                userName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          AppStrings.quote,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              InkWell(
                                onTap: () async {
                                  Platform.isAndroid || Platform.isIOS
                                      ? Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => WebviewPage(
                                              title: 'Test',
                                              url: 'https://jsonplaceholder.typicode.com/',
                                            ),
                                          ),
                                        )
                                      : await _launchUrl();
                                },
                                child: ContainerCustom(
                                  label: AppStrings.vihicle,
                                  icon: Mdi.carSide,
                                  sizewidth: MediaQuery.of(context).size.width / 4,
                                  sizeheight: 90,
                                ),
                              ),
                              SizedBox(width: 8),
                              ContainerCustom(
                                label: AppStrings.residence,
                                icon: Mdi.home,
                                sizewidth: MediaQuery.of(context).size.width / 4,
                                sizeheight: 90,
                              ),
                              SizedBox(width: 8),
                              ContainerCustom(
                                label: AppStrings.life,
                                icon: Mdi.heartPulse,
                                sizewidth: MediaQuery.of(context).size.width / 4,
                                sizeheight: 90,
                              ),
                              SizedBox(width: 8),
                              ContainerCustom(
                                label: AppStrings.personalAccidents,
                                icon: Mdi.accountAlert,
                                sizewidth: MediaQuery.of(context).size.width / 4,
                                sizeheight: 90,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          AppStrings.myFamily,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ContainerCustom(
                          label: AppStrings.addFamily,
                          icon: Mdi.plusCircleOutline,
                          sizewidth: MediaQuery.of(context).size.width * 0.9,
                          sizeheight: 160,
                        ),
                        SizedBox(height: 16),
                        Text(
                          AppStrings.hired,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ContainerCustom(
                          label: AppStrings.messageQuote,
                          icon: Mdi.emoticonSadOutline,
                          sizewidth: MediaQuery.of(context).size.width * 0.9,
                          sizeheight: 160,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            drawer: DrawerCustom(
              userName: userName,
              userPhoto: userPhoto ?? '',
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
