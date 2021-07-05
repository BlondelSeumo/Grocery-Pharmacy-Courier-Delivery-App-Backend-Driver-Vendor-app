import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Edit Profile",
        "fr": "Editer le profil",
        "es": "Editar perfil",
        "de": "Profil bearbeiten",
        "pt": "Editar Perfil",
        "ar": "تعديل الملف الشخصي",
        "ko": "프로필 수정"
      } +
      {
        "en": "Name",
        "fr": "Nom",
        "es": "Nombre",
        "de": "Name",
        "pt": "Nome",
        "ar": "اسم",
        "ko": "이름"
      } +
      {
        "en": "Update Profile",
        "fr": "Mettre à jour le profil",
        "es": "Actualización del perfil",
        "de": "Profil aktualisieren",
        "pt": "Atualizar perfil",
        "ar": "تحديث الملف",
        "ko": "프로필 업데이트"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
