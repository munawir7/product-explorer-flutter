
import 'package:flutter/foundation.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';

class ProductProvider extends ChangeNotifier {
  final GetProducts getProducts;

  ProductProvider(this.getProducts);

  // ==========================================================
  // PRODUCTS
  // ==========================================================

  List<Product> _allProducts = [];
  List<Product> _visibleProducts = [];

  // ==========================================================
  // SEARCH & CATEGORY
  // ==========================================================

  String _searchText = '';
  String _selectedCategory = 'All';

  // ==========================================================
  // LOADING
  // ==========================================================

  bool _isLoading = false;
  bool _isLoadingMore = false;

  // ==========================================================
  // ERROR
  // ==========================================================

  String? _errorMessage;

  // ==========================================================
  // PAGINATION
  // ==========================================================

  static const int _batchSize = 10;

  int _visibleCount = _batchSize;

  // ==========================================================
  // FAVORITES
  // ==========================================================

  final Set<String> _favoriteProductIds = {};

  // ==========================================================
  // GETTERS
  // ==========================================================

  /// Products currently visible on HomePage.
  List<Product> get products => _visibleProducts;

  /// ALL products.
  ///
  /// This is used by CartPage and FavoritesPage so that
  /// search/category filtering does not hide cart/favorite items.
  List<Product> get allProducts => _allProducts;

  String get searchText => _searchText;

  String get selectedCategory => _selectedCategory;

  bool get isLoading => _isLoading;

  bool get isLoadingMore => _isLoadingMore;

  String? get errorMessage => _errorMessage;

  /// Returns all products currently marked as favorites.
  List<Product> get favoriteProducts {
    return _allProducts
        .where(
          (product) =>
              _favoriteProductIds.contains(product.id),
        )
        .toList();
  }

  // ==========================================================
  // LOAD PRODUCTS
  // ==========================================================

  void loadProducts() {
    _isLoading = true;
    _errorMessage = null;

    notifyListeners();

    try {
      _allProducts = getProducts();

      _visibleCount = _batchSize;

      _applyFilters();
    } catch (e) {
      _allProducts = [];
      _visibleProducts = [];

      _errorMessage =
          'Unable to load products. Please try again.';
    }

    _isLoading = false;

    notifyListeners();
  }

  // ==========================================================
  // SEARCH
  // ==========================================================

  void searchProducts(String value) {
    _searchText = value;

    // Start from the first batch after searching.
    _visibleCount = _batchSize;

    _applyFilters();

    notifyListeners();
  }

  // ==========================================================
  // CATEGORY
  // ==========================================================

  void selectCategory(String category) {
    _selectedCategory = category;

    // Start from the first batch after category change.
    _visibleCount = _batchSize;

    _applyFilters();

    notifyListeners();
  }

  // ==========================================================
  // LOAD MORE PRODUCTS
  // ==========================================================

  Future<void> loadMoreProducts() async {
    // Prevent multiple loading operations.
    if (_isLoadingMore) return;

    final filteredProducts = _filteredProducts();

    // Nothing more to load.
    if (_visibleCount >= filteredProducts.length) {
      return;
    }

    _isLoadingMore = true;

    notifyListeners();

    try {
      // Simulate loading delay.
      await Future.delayed(
        const Duration(milliseconds: 500),
      );

      // Add another batch.
      _visibleCount += _batchSize;

      // Don't go beyond available products.
      if (_visibleCount > filteredProducts.length) {
        _visibleCount = filteredProducts.length;
      }

      _applyFilters();
    } finally {
      _isLoadingMore = false;

      notifyListeners();
    }
  }

  // ==========================================================
  // FAVORITES
  // ==========================================================

  bool isFavorite(String productId) {
    return _favoriteProductIds.contains(productId);
  }

  void toggleFavorite(String productId) {
    if (_favoriteProductIds.contains(productId)) {
      _favoriteProductIds.remove(productId);
    } else {
      _favoriteProductIds.add(productId);
    }

    notifyListeners();
  }

  // ==========================================================
  // FILTER PRODUCTS
  // ==========================================================

  List<Product> _filteredProducts() {
    return _allProducts.where((product) {
      final matchesSearch = product.name
          .toLowerCase()
          .contains(
            _searchText.toLowerCase(),
          );

      final matchesCategory =
          _selectedCategory == 'All' ||
          product.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  // ==========================================================
  // APPLY FILTERS
  // ==========================================================

  void _applyFilters() {
    final filteredProducts =
        _filteredProducts();

    final count =
        _visibleCount > filteredProducts.length
            ? filteredProducts.length
            : _visibleCount;

    _visibleProducts =
        filteredProducts.take(count).toList();
  }
}

