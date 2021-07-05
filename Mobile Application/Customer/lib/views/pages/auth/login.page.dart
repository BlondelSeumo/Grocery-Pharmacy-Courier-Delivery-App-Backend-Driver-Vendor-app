import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/view_models/login.view_model.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';

import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/login.i18n.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return BasePage(
          showLeadingAction: true,
          showAppBar: true,
          body: SafeArea(
            top: true,
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(bottom: context.mq.viewInsets.bottom),
              child: VStack(
                [
                  Image.asset(
                    AppImages.onboarding1,
                  ).hOneForth(context).centered(),
                  //
                  VStack(
                    [
                      //
                      "Welcome Back".i18n.text.xl2.semiBold.make(),
                      "Login to continue".i18n.text.light.make(),

                      //form
                      Form(
                        key: model.formKey,
                        child: VStack(
                          [
                            //
                            CustomTextFormField(
                              labelText: "Email",
                              keyboardType: TextInputType.emailAddress,
                              textEditingController: model.emailTEC,
                              validator: FormValidator.validateEmail,
                            ).py12(),
                            CustomTextFormField(
                              labelText: "Password".i18n,
                              obscureText: true,
                              textEditingController: model.passwordTEC,
                              validator: FormValidator.validatePassword,
                            ).py12(),

                            //
                            "Forgot Password ?"
                                .i18n
                                .text
                                .underline
                                .make()
                                .onInkTap(
                                  model.openForgotPassword,
                                ),
                            //
                            CustomButton(
                              title: "Login".i18n,
                              loading: model.isBusy,
                              onPressed: model.processLogin,
                            ).centered().py12(),

                            //register
                            "OR".i18n.text.light.makeCentered(),
                            "Create An Account"
                                .i18n
                                .text
                                .semiBold
                                .makeCentered()
                                .py12()
                                .onInkTap(model.openRegister),
                          ],
                          crossAlignment: CrossAxisAlignment.end,
                        ),
                      ).py20(),
                    ],
                  )
                      .wFull(context)
                      .p20(),
                  //
                ],
              ).scrollVertical(),
            ),
          ),
        );
      },
    );
  }
}
