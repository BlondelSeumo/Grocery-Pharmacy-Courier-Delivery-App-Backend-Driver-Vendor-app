import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Products",
        "fr": "Des produits",
        "es": "Productos",
        "de": "Produkte",
        "pt": "Produtos",
        "ar": "منتجات",
        "ko": "제품"
      } +
      {
        "en": "Search",
        "fr": "Rechercher",
        "es": "Buscar",
        "de": "Suche",
        "pt": "Procurar",
        "ar": "يبحث",
        "ko": "검색"
      } +
      {
        "en": "Deliverable",
        "fr": "Livrable",
        "es": "Entregables",
        "de": "Lieferbar",
        "pt": "Entregável",
        "ar": "التسليم",
        "ko": "결과물"
      } +
      {
        "en": "Not Deliverable",
        "fr": "Non livrable",
        "es": "No entregable",
        "de": "Nicht lieferbar",
        "pt": "Não Entregável",
        "ar": "غير قابل للتسليم",
        "ko": "배송 불가"
      } +
      {
        "en": "%s Items",
        "fr": "%s éléments",
        "es": "%s artículos",
        "de": "%s Artikel",
        "pt": "%s itens",
        "ar": "%s عناصر",
        "ko": "%s 항목"
      } +
      {
        "en": "Options",
        "fr": "Options",
        "es": "Opciones",
        "de": "Optionen",
        "pt": "Opções",
        "ar": "خيارات",
        "ko": "옵션"
      } +
      {
        "en": "Available options attached to this product",
        "fr": "Options disponibles attachées à ce produit",
        "es": "Opciones disponibles adjuntas a este producto",
        "de": "Verfügbare Optionen für dieses Produkt",
        "pt": "Opções disponíveis anexadas a este produto",
        "ar": "الخيارات المتاحة المرفقة بهذا المنتج",
        "ko": "이 제품에 첨부 된 사용 가능한 옵션"
      } +
      {
        "en": "No Product",
        "fr": "Aucun produit",
        "es": "Sin producto",
        "de": "Kein Produkt",
        "pt": "Sem produto",
        "ar": "لا يوجد منتج",
        "ko": "제품 없음"
      } +
      {
        "en": "All products will appear here",
        "fr": "Tous les produits apparaîtront ici",
        "es": "Todos los productos aparecerán aquí",
        "de": "Alle Produkte werden hier angezeigt",
        "pt": "Todos os produtos aparecerão aqui",
        "ar": "ستظهر جميع المنتجات هنا",
        "ko": "모든 제품이 여기에 표시됩니다."
      } +
      {
        "en": "New Product",
        "fr": "Nouveau produit",
        "es": "Nuevo producto",
        "de": "Neues Produkt",
        "pt": "Novo produto",
        "ar": "منتج جديد",
        "ko": "신상품"
      } +
      {
        "en": "Deactivate",
        "fr": "Désactiver",
        "es": "Desactivar",
        "de": "Deaktivieren",
        "pt": "Desativar",
        "ar": "تعطيل",
        "ko": "비활성화"
      } +
      {
        "en": "Delete",
        "fr": "Effacer",
        "es": "Borrar",
        "de": "Löschen",
        "pt": "Excluir",
        "ar": "حذف",
        "ko": "지우다"
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
        "en": "Description",
        "fr": "La description",
        "es": "Descripción",
        "de": "Beschreibung",
        "pt": "Descrição",
        "ar": "وصف",
        "ko": "기술"
      } +
      {
        "en": "Price",
        "fr": "Prix",
        "es": "Precio",
        "de": "Preis",
        "pt": "Preço",
        "ar": "سعر",
        "ko": "가격"
      } +
      {
        "en": "Discount Price",
        "fr": "Prix bas",
        "es": "Precio de descuento",
        "de": "Reduzierter Preis",
        "pt": "Preço com desconto",
        "ar": "سعر الخصم",
        "ko": "할인 가격"
      } +
      {
        "en": "Capacity",
        "fr": "Capacité",
        "es": "Capacidad",
        "de": "Kapazität",
        "pt": "Capacidade",
        "ar": "الاهلية",
        "ko": "생산 능력"
      } +
      {
        "en": "Unit",
        "fr": "Unité",
        "es": "Unidad",
        "de": "Einheit",
        "pt": "Unidade",
        "ar": "وحدة",
        "ko": "단위"
      } +
      {
        "en": "Package Count",
        "fr": "Nombre de colis",
        "es": "Cantidad de paquetes",
        "de": "Paketanzahl",
        "pt": "Contagem de pacotes",
        "ar": "عدد العبوات",
        "ko": "패키지 수"
      } +
      {
        "en": "Available Qty",
        "fr": "Quantité disponible",
        "es": "Cantidad disponible",
        "de": "Verfügbare Menge",
        "pt": "Qtd disponivel",
        "ar": "الكمية المتوفرة",
        "ko": "사용 가능한 수량"
      } +
      {
        "en": "Can be delivered",
        "fr": "Peut être livré",
        "es": "Puede ser entregado",
        "de": "Kann geliefert werden",
        "pt": "Pode ser entregue",
        "ar": "يمكن تسليمها",
        "ko": "배달 가능"
      } +
      {
        "en": "Active",
        "fr": "actif",
        "es": "Activo",
        "de": "Aktiv",
        "pt": "Ativo",
        "ar": "نشيط",
        "ko": "유효한"
      } +
      {
        "en": "Category",
        "fr": "Catégorie",
        "es": "Categoría",
        "de": "Kategorie",
        "pt": "Categoria",
        "ar": "فئة",
        "ko": "범주"
      } +
      {
        "en": "Sub-Category",
        "fr": "Sous-catégorie",
        "es": "Subcategoría",
        "de": "Unterkategorie",
        "pt": "Subcategoria",
        "ar": "تصنيف فرعي",
        "ko": "하위 카테고리"
      } +
      {
        "en": "Menus",
        "fr": "Menus",
        "es": "Menús",
        "de": "Menüs",
        "pt": "Menus",
        "ar": "القوائم",
        "ko": "메뉴"
      } +
      {
        "en": "Save Product",
        "fr": "Enregistrer le produit",
        "es": "Guardar producto",
        "de": "Produkt speichern",
        "pt": "Salvar Produto",
        "ar": "حفظ المنتج",
        "ko": "제품 저장"
      } +
      {
        "en": "Delete Product",
        "fr": "Supprimer le produit",
        "es": "Eliminar producto",
        "de": "Produkt löschen",
        "pt": "Excluir Produto",
        "ar": "حذف المنتج",
        "ko": "제품 삭제"
      } +
      {
        "en": "Are you sure you want to delete",
        "fr": "Etes-vous sûr que vous voulez supprimer",
        "es": "estas seguro que quieres borrarlo",
        "de": "Sind Sie sicher, dass Sie löschen möchten",
        "pt": "Tem certeza de que deseja excluir",
        "ar": "هل أنت متأكد أنك تريد حذف",
        "ko": "삭제 하시겠습니까"
      } +
      {
        "en": "Activate",
        "fr": "Activer",
        "es": "Activar",
        "de": "aktivieren Sie",
        "pt": "Ativar",
        "ar": "تفعيل",
        "ko": "활성화"
      } +
      {
        "en": "Deactivate",
        "fr": "Désactiver",
        "es": "Desactivar",
        "de": "Deaktivieren",
        "pt": "Desativar",
        "ar": "تعطيل",
        "ko": "비활성화"
      } +
      {
        "en": "Status Update",
        "fr": "Mise à jour du statut",
        "es": "Actualización de estado",
        "de": "Status-Update",
        "pt": "Atualização de status",
        "ar": "تحديث الحالة",
        "ko": "상황 업데이트"
      } +
      {
        "en": "Are you sure you want to",
        "fr": "Êtes-vous sûr de vouloir",
        "es": "Estás seguro que quieres",
        "de": "Bist du sicher, dass du das willst",
        "pt": "Você tem certeza que quer",
        "ar": "هل أنت متأكد أنك تريد",
        "ko": "하시겠습니까?"
      } +
      {
        "en": "Edit Product",
        "fr": "Modifier le produit",
        "es": "Editar producto",
        "de": "Produkt bearbeiten",
        "pt": "Editar Produto",
        "ar": "تحرير المنتج",
        "ko": "제품 수정"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
