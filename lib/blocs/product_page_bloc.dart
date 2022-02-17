import '../source.dart';

class ProductPageBloc extends Cubit<ProductPageState> {
  ProductPageBloc(this.service, this.categoriesService)
      : super(ProductPageState.initial()) {
    service.addListener(() => _handleproductUpdates());
    categoriesService.addListener(() => _handleCategoryUpdates());
  }

  final ProductsService service;
  final CategoriesService categoriesService;

  Category? get getSelectedCategory {
    final id = state.supplements.categoryId;
    final category = categoriesService.getCategoryById(id);
    return category;
  }

  ///product should be specified when it is to be edited.
  ///Category is passed when product is created for the first time.
  ///Also category is needed on category page that displays all products of the same ID
  void init({Product? product, String? categoryId}) {
    var supp = state.supplements;
    emit(ProductPageState.loading(supp));
    var productList = service.getAll();
    final categories = categoriesService.getAll();

    if (categoryId != null) {
      productList = productList.where((e) => e.categoryId == categoryId).toList();
      supp = supp.copyWith(categoryId: categoryId);
    }

    supp = supp.copyWith(productList: productList, categoryList: categories);

    if (product != null) {
      supp = supp.copyWith(
        unit: product.unit,
        unitPrice: product.unitPrice.toString(),
        name: product.name,
        quantity: product.quantity.toString(),
        categoryId: product.categoryId,
        id: product.id,
        barcode: product.barcode,
      );
    }
    emit(ProductPageState.content(supp));
  }

  void updateAttributes(
      {String? name,
      String? categoryId,
      String? unit,
      String? barcode,
      String? unitPrice,
      String? quantity}) {
    var supp = state.supplements;
    emit(ProductPageState.loading(supp));

    supp = supp.copyWith(
        name: name?.trim() ?? supp.name,
        unit: unit?.trim() ?? supp.unit,
        categoryId: categoryId ?? supp.categoryId,
        unitPrice: unitPrice?.trim() ?? supp.unitPrice,
        quantity: quantity?.trim() ?? supp.quantity,
        barcode: barcode?.trim() ?? supp.barcode);
    emit(ProductPageState.content(supp));
  }

  void saveProduct() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final product = Product(
        id: Utils.getRandomId(),
        categoryId: supp.categoryId,
        unit: supp.unit,
        name: supp.name,
        barcode: supp.barcode,
        unitPrice: double.parse(supp.unitPrice),
        quantity: double.parse(supp.quantity));
    await service.addProduct(product);
    emit(ProductPageState.success(supp));
  }

  void editProduct() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final product = Product(
        id: supp.id,
        categoryId: supp.categoryId,
        unit: supp.unit,
        name: supp.name,
        barcode: supp.barcode,
        unitPrice: double.parse(supp.unitPrice),
        quantity: double.parse(supp.quantity));
    await service.editProduct(product);
    emit(ProductPageState.success(supp));
  }

  _validate() {
    var supp = state.supplements;
    final errors = <String, String?>{};

    emit(ProductPageState.loading(supp));
    errors['name'] = InputValidation.validateText(supp.name, 'name');
    errors['unit'] = InputValidation.validateText(supp.unit, 'Unit');
    errors['category'] =
        InputValidation.validateText(supp.categoryId, 'Category');

    errors['unitPrice'] =
        InputValidation.validateNumber(supp.unitPrice, 'Unit Price');
    errors['quantity'] =
        InputValidation.validateNumber(supp.quantity, 'Quantity');

    supp = supp.copyWith(errors: errors);
    emit(ProductPageState.content(supp));
  }

  _handleproductUpdates() {
    var supp = state.supplements;
    emit(ProductPageState.loading(supp));
    final products = service.getProductList;
    supp = supp.copyWith(productList: products);
    emit(ProductPageState.content(supp));
  }

  _handleCategoryUpdates() {
    var supp = state.supplements;
    emit(ProductPageState.loading(supp));
    final id = categoriesService.getSelectedCategoryId;
    supp = supp.copyWith(categoryId: id);
    emit(ProductPageState.content(supp));
  }
}
