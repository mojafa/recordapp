import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:record_app/config/AppRoutes.dart';
import 'package:record_app/mixins/BaseMixins.dart';
import 'package:record_app/providers/AuthProvider.dart';
import 'package:record_app/providers/ThemeProvider.dart';
import 'package:record_app/screens/DownloadScreen.dart';
import 'package:record_app/screens/admin/admin_add_podcast.dart';
import 'package:record_app/screens/contact/about_page.dart';
import 'package:record_app/screens/contact/contact_page.dart';
import 'package:record_app/widgtes/Common/BaseImage.dart';
import 'package:record_app/widgtes/Common/CustomCircularProgressIndicator.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class UserAccountPage extends StatelessWidget with BaseMixins {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthenticationProvider>(context);
    GlobalConfiguration cfg = new GlobalConfiguration();

    var themeProvider = Provider.of<ThemeProvider>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: Text($t(context, 'account')),
        elevation: 0.0,
      ),
      body: provider.isLoaded
          ? SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Card(
                    elevation: 2,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: provider.isLoggedIn
                        ? ListTile(
                            leading: Container(
                              height: 40,
                              width: 40,
                              child: BaseImage(
                                radius: 5,
                                height: 40,
                                width: 40,
                                imageUrl: provider.user.avatar,
                              ),
                            ),
                            title: Text(provider.user.firstName),
                            subtitle: Text(provider.user.email),
                            trailing: Icon(Icons.edit),
                            onTap: () => Navigator.of(context).pushNamed(
                              AppRoutes.profileEditRoute,
                              arguments: '1', //user.id
                            ),
                          )
                        : Column(
                            children: <Widget>[
                              ListTile(
                                title: Text('Download Manager'),
                                leading: Icon(
                                  Icons.cloud_download_sharp,
                                  size: 22,
                                ),
                                onTap: () {
                                  Get.to(() => DownloadScreen());
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text('Share the app'),
                                leading: Icon(
                                  Icons.share,
                                  size: 22,
                                ),
                                onTap: () {
                                  Share.share(
                                      'The appstore and play store links will be here');
                                },
                              ),
                              // Divider(height: 0),
                              // ListTile(
                              //   title: FirebaseAuth.instance.currentUser != null
                              //       ? Text('Admin Panel')
                              //       : Text($t(context, 'sign_in')),
                              //   leading: Icon(
                              //     Icons.verified_user,
                              //     size: 22,
                              //   ),
                              //   onTap: FirebaseAuth.instance.currentUser != null
                              //       ? () => Get.to(() => AdminAddPodcast())
                              //       : () => Navigator.pushNamed(
                              //           context, AppRoutes.loginRoute),
                              // ),
                              // Divider(height: 0),
                              // if (FirebaseAuth.instance.currentUser == null)
                              //   ListTile(
                              //     title: Text($t(
                              //       context,
                              //       'create_new_Account',
                              //     )),
                              //     leading: Icon(
                              //       Icons.account_circle,
                              //       size: 22,
                              //     ),
                              //     onTap: () => Navigator.pushNamed(
                              //         context, AppRoutes.registerRoute),
                              //   ),
                            ],
                          ),
                  ),
                  SizedBox(height: 5),
                  if (provider.isLoggedIn)
                    Card(
                      elevation: 2,
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text($t(
                              context,
                              'your_payments',
                            )),
                            leading: Icon(
                              Icons.monetization_on,
                              size: 22,
                            ),
                            onTap: () => {},
                          ),
                          Divider(height: 0),
                          ListTile(
                            title: Text($t(
                              context,
                              'save_payments',
                            )),
                            leading: Icon(
                              Icons.credit_card,
                              size: 22,
                            ),
                            onTap: () => {},
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 10),
                  Card(
                    elevation: 2,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Column(
                      children: <Widget>[
                        // cfg.getValue("allowDownload")
                        //     ? ListTile(
                        //         title: Text($t(context, 'download')),
                        //         leading: Icon(
                        //           Icons.download_sharp,
                        //           size: 22,
                        //         ),
                        //         onTap: () => {
                        //           Navigator.pushNamed(
                        //               context, AppRoutes.downloadScreenRoute)
                        //         },
                        //       )
                        //     :
                        //      Divider(
                        //         height: 0,
                        //       ),
                        ListTile(
                          title: Text($t(
                            context,
                            'about',
                          )),
                          leading: Icon(
                            Icons.info,
                            size: 22,
                          ),
                          onTap: () => {Get.to(() => AboutScreen())},
                        ),
                        Divider(height: 0),
                        ListTile(
                          title: Text($t(context, 'rate')),
                          leading: Icon(
                            Icons.star,
                            size: 22,
                          ),
                          onTap: () => {},
                        ),
                        // Divider(height: 0),
                        // ListTile(
                        //   title: Text($t(context, 'Contact us')),
                        //   leading: Icon(
                        //     Icons.help,
                        //     size: 22,
                        //   ),
                        //   onTap: () => {Get.to(() => ContactPage())},
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  if (provider.isLoggedIn)
                    Card(
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              $t(
                                context,
                                'sign_out',
                              ),
                            ),
                            leading: Icon(
                              Icons.account_circle,
                              size: 22,
                            ),
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                            },
                          ),
                        ],
                      ),
                    ),
                  Card(
                    margin: EdgeInsets.all(0),
                    child: ListTile(
                      title: Text($t(
                        context,
                        'mode_String',
                      )),
                      trailing: Switch(
                          value: themeProvider.darkMode,
                          onChanged: (val) {
                            themeProvider.toggleChangeTheme();
                          }),
                      leading: Icon(
                        Icons.star,
                        size: 22,
                      ),
                      onTap: () => {},
                    ),
                  ),
                ],
              ),
            )
          : CustomCircularProgressIndicator(),
    );
  }
}
