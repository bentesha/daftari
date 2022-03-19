import '../source.dart';

class ProductPagesBloc extends Cubit<ProductPageState> {
  ProductPagesBloc(this.productsService, this.categoriesService,
      this.openingStockItemsService)
      : super(ProductPageState.initial()) {
    productsService.addListener(_handleProductUpdates);
    categoriesService.addListener(_handleCategoryUpdates);
  }

  ProductPagesBloc.empty()
      : categoriesService = CategoriesService(),
        productsService = ProductsService(),
        openingStockItemsService = OpeningStockItemsService(),
        super(ProductPageState.initial());

  final ProductsService productsService;
  final CategoriesService categoriesService;
  final OpeningStockItemsService openingStockItemsService;

  Category? get getSelectedCategory {
    final id = state.supplements.product.categoryId;
    final category = categoriesService.getById(id);
    return category;
  }

  void init(Pages page, {Product? product, PageActions? action}) async {
    var supp = state.supplements;
    emit(ProductPageState.loading(supp));

    final isSuccessful = await _initServices();
    if (!isSuccessful) return;
    _initProductsPage(page);
    _initProductPage(page, action, product);
  }

  void updateAttributes(
      {String? name,
      String? categoryId,
      String? unit,
      String? code,
      String? unitValue,
      String? description,
      String? unitPrice,
      PageActions? action,
      String? quantity}) {
    var supp = state.supplements;
    emit(ProductPageState.loading(supp));

    final product = supp.product
        .copyWith(name: name, unit: unit, categoryId: categoryId, code: code);

    supp = supp.copyWith(
        product: product,
        description: description,
        unitValue: unitValue?.trim() ?? supp.unitValue,
        unitPrice: unitPrice?.trim() ?? supp.unitPrice,
        quantity: quantity?.trim() ?? supp.quantity,
        action: action ?? supp.action);
    emit(ProductPageState.content(supp));
  }

  void saveProduct() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(ProductPageState.loading(supp));

    try {
      await productsService.add(supp.getProduct);

      if (supp.hasAddedOpeningStockDetails) {
        final product = productsService.getCurrent;

        final openingStockItem = OpeningStockItem(
            date: DateFormatter.convertToDMY(DateTime.now()),
            productId: product.id,
            unitValue: supp.parsedUnitValue,
            description: supp.description,
            quantity: supp.parsedQuantity);
        await openingStockItemsService.add(openingStockItem);
      }
      emit(ProductPageState.success(supp));
    } catch (e) {
      _handleError(e);
    }
  }

  void editProduct() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(ProductPageState.loading(supp));
    try {
      await productsService.edit(supp.getProduct);
      emit(ProductPageState.success(supp));
    } catch (e) {
      _handleError(e);
    }
  }

  void deleteProduct() async {
    var supp = state.supplements;
    emit(ProductPageState.loading(supp));

    try {
      await productsService.delete(supp.product.id);
      emit(ProductPageState.success(supp));
    } catch (e) {
      _handleError(e);
    }
  }

  void updateAction(PageActions action) => updateAttributes(action: action);

  _validate() {
    var supp = state.supplements;
    final errors = <String, String?>{};

    emit(ProductPageState.loading(supp));
    errors['name'] = InputValidation.validateText(supp.product.name, 'name');
    errors['unit'] = InputValidation.validateText(supp.product.unit, 'Unit');
    errors['category'] =
        InputValidation.validateText(supp.product.categoryId, 'Category');
    errors['unitPrice'] =
        InputValidation.validateNumber(supp.unitPrice, 'Unit Price');

    if (supp.hasAddedOpeningStockDetails) {
      errors['unitValue'] =
          InputValidation.validateNumber(supp.unitValue, 'Unit Value');
      errors['quantity'] =
          InputValidation.validateNumber(supp.quantity, 'Quantity');
    }

    supp = supp.copyWith(errors: errors);
    emit(ProductPageState.content(supp));
  }

  _handleProductUpdates() {
    var supp = state.supplements;
    emit(ProductPageState.loading(supp));
    final products = productsService.getList;
    supp = supp.copyWith(productList: products);
    emit(ProductPageState.content(supp));
  }

  _handleCategoryUpdates() {
    var supp = state.supplements;
    emit(ProductPageState.loading(supp));
    final id = categoriesService.getCurrent.id;
    supp = supp.copyWith(product: supp.product.copyWith(categoryId: id));
    emit(ProductPageState.content(supp));
  }

  _initProductsPage(Pages page) {
    if (page != Pages.products_page) return;
    var supp = state.supplements;
    var productList = productsService.getList;
    final categories = categoriesService.getList;

    supp = supp.copyWith(productList: productList, categoryList: categories);
    emit(ProductPageState.content(supp));
  }

  _initProductPage(Pages page, PageActions? action, [Product? product]) {
    if (page != Pages.product_page) return;

    var supp = state.supplements;
    supp = supp.copyWith(action: action!);

    if (product != null) {
      supp = supp.copyWith(
          product: product, unitPrice: product.unitPrice.toString());
    }
    emit(ProductPageState.content(supp));
  }

  Future<bool> _initServices() async {
    var isSuccessful = false;
    try {
      await categoriesService.init();
      await productsService.init();
      await openingStockItemsService.init();
      isSuccessful = true;
    } on ApiErrors catch (e) {
      emit(ProductPageState.failed(state.supplements,
          message: e.message, showOnPage: true));
    }
    return isSuccessful;
  }

  void _handleError(var error) {
    final message = getErrorMessage(error);
    emit(ProductPageState.failed(state.supplements, message: message));
  }
}
