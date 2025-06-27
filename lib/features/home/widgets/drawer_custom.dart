import 'package:challenge_direct_solution/core/utils/app_colors.dart';
import 'package:challenge_direct_solution/core/utils/app_strings.dart';

import '../../../core/routes/routes.dart';
import '../../auth/presentation/cubit/auth_cubit.dart';
import 'list_tile_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerCustom extends StatelessWidget {
  final String userName;
  final String? userPhoto;

  const DrawerCustom({
    super.key,
    required this.userName,
    required this.userPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.backgroundMedium,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: userPhoto != null
                      ? NetworkImage(userPhoto!)
                      : const AssetImage('assets/user.jpeg') as ImageProvider,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        userName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        AppStrings.myAccount,
                        style: TextStyle(
                          color: context.greenAceent,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          ListTileCustom(
            title: AppStrings.home,
            icon: Icons.settings,
            onTap: () {},
          ),
          ListTileCustom(
            title: AppStrings.myHires,
            icon: Icons.settings,
            onTap: () {},
          ),
          ListTileCustom(
            title: AppStrings.myClaims,
            icon: Icons.settings,
            onTap: () {},
          ),
          ListTileCustom(
            title: AppStrings.myFamily,
            icon: Icons.settings,
            onTap: () {},
          ),
          ListTileCustom(
            title: AppStrings.myGoods,
            icon: Icons.settings,
            onTap: () {},
          ),
          ListTileCustom(
            title: AppStrings.payment,
            icon: Icons.settings,
            onTap: () {},
          ),
          ListTileCustom(
            title: AppStrings.coverage,
            icon: Icons.settings,
            onTap: () {},
          ),
          ListTileCustom(
            title: AppStrings.validateTicket,
            icon: Icons.settings,
            onTap: () {},
          ),
          ListTileCustom(
            title: AppStrings.importanteNumber,
            icon: Icons.settings,
            onTap: () {},
          ),
          ListTileCustom(
            title: AppStrings.settings,
            icon: Icons.settings,
            onTap: () {},
          ),
          ListTileCustom(
              title: AppStrings.exit,
              icon: Icons.logout,
              onTap: () {
                context.read<AuthCubit>().logout();
                Navigator.of(context).pushReplacementNamed(Routes.login);
              }),
        ],
      ),
    );
  }
}
