
import '../models/product_model.dart';

class ProductLocalDataSource {
  final List<ProductModel> products = [
    // ---------------- ELECTRONICS ----------------

    const ProductModel(
      id: '1',
      name: 'Wireless Earbuds',
      category: 'Electronics',
      price: 1999,
      rating: 4.8,
      image:
          'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf1',
      description:
          'High-quality wireless earbuds with clear sound and comfortable fit.',
    ),

    const ProductModel(
      id: '2',
      name: 'Smart Watch',
      category: 'Electronics',
      price: 3999,
      rating: 4.7,
      image:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30',
      description:
          'Smart watch with fitness tracking and notification features.',
    ),

    const ProductModel(
      id: '3',
      name: 'Wireless Headphones',
      category: 'Electronics',
      price: 2999,
      rating: 4.6,
      image:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
      description:
          'Comfortable wireless headphones with immersive audio.',
    ),

    const ProductModel(
      id: '4',
      name: 'Bluetooth Speaker',
      category: 'Electronics',
      price: 2499,
      rating: 4.5,
      image:
          'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1',
      description:
          'Portable Bluetooth speaker with powerful sound.',
    ),

    const ProductModel(
      id: '5',
      name: 'Digital Camera',
      category: 'Electronics',
      price: 24999,
      rating: 4.8,
      image:
          'https://images.unsplash.com/photo-1516035069371-29a1b244cc32',
      description:
          'Compact digital camera for capturing high-quality photos.',
    ),

    const ProductModel(
      id: '6',
      name: 'Mechanical Keyboard',
      category: 'Electronics',
      price: 4599,
      rating: 4.7,
      image:
          'https://images.unsplash.com/photo-1587829741301-dc798b83add3',
      description:
          'Mechanical keyboard designed for comfortable typing.',
    ),

    const ProductModel(
      id: '7',
      name: 'Wireless Mouse',
      category: 'Electronics',
      price: 1299,
      rating: 4.5,
      image:
          'https://images.unsplash.com/photo-1527814050087-3793815479db',
      description:
          'Ergonomic wireless mouse suitable for work and gaming.',
    ),

    const ProductModel(
      id: '8',
      name: 'Tablet',
      category: 'Electronics',
      price: 18999,
      rating: 4.6,
      image:
          'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0',
      description:
          'Lightweight tablet suitable for entertainment and productivity.',
    ),

    // ---------------- FASHION ----------------

    const ProductModel(
      id: '9',
      name: 'Classic T-Shirt',
      category: 'Fashion',
      price: 899,
      rating: 4.5,
      image:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab',
      description:
          'Comfortable cotton t-shirt with a classic everyday design.',
    ),

    const ProductModel(
      id: '10',
      name: 'Denim Jacket',
      category: 'Fashion',
      price: 2499,
      rating: 4.7,
      image:
          'https://images.unsplash.com/photo-1551028719-00167b16eac5',
      description:
          'Stylish denim jacket suitable for casual outfits.',
    ),

    const ProductModel(
      id: '11',
      name: 'Casual Shirt',
      category: 'Fashion',
      price: 1299,
      rating: 4.4,
      image:
          'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf',
      description:
          'Comfortable casual shirt for everyday wear.',
    ),

    const ProductModel(
      id: '12',
      name: 'Hoodie',
      category: 'Fashion',
      price: 1799,
      rating: 4.8,
      image:
          'https://images.unsplash.com/photo-1556821840-3a63f95609a7',
      description:
          'Warm and comfortable hoodie with a modern fit.',
    ),

    const ProductModel(
      id: '13',
      name: 'Summer Dress',
      category: 'Fashion',
      price: 2199,
      rating: 4.6,
      image:
          'https://images.unsplash.com/photo-1595777457583-95e059d581b8',
      description:
          'Lightweight summer dress with an elegant design.',
    ),

    const ProductModel(
      id: '14',
      name: 'Cotton Kurta',
      category: 'Fashion',
      price: 1499,
      rating: 4.7,
      image:
          'https://images.unsplash.com/photo-1583391733956-6c78276477e2',
      description:
          'Traditional cotton kurta with a comfortable fit.',
    ),

    const ProductModel(
      id: '15',
      name: 'Chinos',
      category: 'Fashion',
      price: 1899,
      rating: 4.5,
      image:
          'https://images.unsplash.com/photo-1473966968600-fa801b869a1a',
      description:
          'Versatile chinos suitable for casual and semi-formal wear.',
    ),

    const ProductModel(
      id: '16',
      name: 'Leather Belt',
      category: 'Fashion',
      price: 999,
      rating: 4.4,
      image:
          'https://images.unsplash.com/photo-1624222247344-550fb60583dc',
      description:
          'Classic leather belt with a durable buckle.',
    ),

    // ---------------- SHOES ----------------

    const ProductModel(
      id: '17',
      name: 'Running Shoes',
      category: 'Shoes',
      price: 2799,
      rating: 4.8,
      image:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
      description:
          'Comfortable running shoes designed for everyday activity.',
    ),

    const ProductModel(
      id: '18',
      name: 'Sports Shoes',
      category: 'Shoes',
      price: 3299,
      rating: 4.7,
      image:
          'https://images.unsplash.com/photo-1552346154-21d32810aba3',
      description:
          'Lightweight sports shoes designed for active lifestyles.',
    ),

    const ProductModel(
      id: '19',
      name: 'Casual Sneakers',
      category: 'Shoes',
      price: 2199,
      rating: 4.6,
      image:
          'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77',
      description:
          'Modern sneakers that work well with casual outfits.',
    ),

    const ProductModel(
      id: '20',
      name: 'Classic Leather Shoes',
      category: 'Shoes',
      price: 3999,
      rating: 4.8,
      image:
          'https://images.unsplash.com/photo-1614252235316-8c857d38b5f4',
      description:
          'Classic leather shoes suitable for formal occasions.',
    ),

    const ProductModel(
      id: '21',
      name: 'Canvas Shoes',
      category: 'Shoes',
      price: 1599,
      rating: 4.4,
      image:
          'https://images.unsplash.com/photo-1495555961986-6d4c1ecb7be3',
      description:
          'Simple and lightweight canvas shoes for everyday use.',
    ),

    const ProductModel(
      id: '22',
      name: 'Walking Shoes',
      category: 'Shoes',
      price: 2399,
      rating: 4.7,
      image:
          'https://images.unsplash.com/photo-1560769629-975ec94e6a86',
      description:
          'Comfortable walking shoes with supportive cushioning.',
    ),

    // ---------------- ACCESSORIES ----------------

    const ProductModel(
      id: '23',
      name: 'Backpack',
      category: 'Accessories',
      price: 1499,
      rating: 4.6,
      image:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62',
      description:
          'Stylish and durable backpack for daily use.',
    ),

    const ProductModel(
      id: '24',
      name: 'Sunglasses',
      category: 'Accessories',
      price: 1299,
      rating: 4.5,
      image:
          'https://images.unsplash.com/photo-1511499767150-a48a237f0083',
      description:
          'Modern sunglasses with a comfortable frame.',
    ),

    const ProductModel(
      id: '25',
      name: 'Travel Bag',
      category: 'Accessories',
      price: 2499,
      rating: 4.7,
      image:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62',
      description:
          'Spacious travel bag for short trips and weekends.',
    ),

    const ProductModel(
      id: '26',
      name: 'Wallet',
      category: 'Accessories',
      price: 799,
      rating: 4.4,
      image:
          'https://images.unsplash.com/photo-1627123424574-724758594e93',
      description:
          'Compact wallet with multiple card slots.',
    ),

    const ProductModel(
      id: '27',
      name: 'Cap',
      category: 'Accessories',
      price: 599,
      rating: 4.3,
      image:
          'https://images.unsplash.com/photo-1521369909029-2afed882baee',
      description:
          'Comfortable everyday cap with an adjustable fit.',
    ),

    const ProductModel(
      id: '28',
      name: 'Watch Strap',
      category: 'Accessories',
      price: 699,
      rating: 4.5,
      image:
          'https://images.unsplash.com/photo-1434056886845-dac89ffe9b56',
      description:
          'Durable replacement watch strap with a stylish finish.',
    ),

    // ---------------- MORE PRODUCTS ----------------

    const ProductModel(
      id: '29',
      name: 'Gaming Controller',
      category: 'Electronics',
      price: 3499,
      rating: 4.8,
      image:
          'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08',
      description:
          'Comfortable wireless controller for gaming.',
    ),

    const ProductModel(
      id: '30',
      name: 'Portable Charger',
      category: 'Electronics',
      price: 1599,
      rating: 4.6,
      image:
          'https://images.unsplash.com/photo-1609592424856-1c8c5c3a7b6c',
      description:
          'Portable power bank for charging devices on the go.',
    ),

    const ProductModel(
      id: '31',
      name: 'Formal Shirt',
      category: 'Fashion',
      price: 1599,
      rating: 4.5,
      image:
          'https://images.unsplash.com/photo-1596755094514-f87e34085b2c',
      description:
          'Smart formal shirt for office and professional occasions.',
    ),

    const ProductModel(
      id: '32',
      name: 'Track Pants',
      category: 'Fashion',
      price: 1199,
      rating: 4.6,
      image:
          'https://images.unsplash.com/photo-1552902865-b72c031ac5ea',
      description:
          'Comfortable track pants for workouts and casual wear.',
    ),

    const ProductModel(
      id: '33',
      name: 'High Top Sneakers',
      category: 'Shoes',
      price: 2999,
      rating: 4.7,
      image:
          'https://images.unsplash.com/photo-1520256862855-398228c41684',
      description:
          'Stylish high-top sneakers with a modern streetwear design.',
    ),

    const ProductModel(
      id: '34',
      name: 'Slip-On Shoes',
      category: 'Shoes',
      price: 1899,
      rating: 4.5,
      image:
          'https://images.unsplash.com/photo-1562183241-b937e95585b6',
      description:
          'Easy-to-wear slip-on shoes for everyday comfort.',
    ),

    const ProductModel(
      id: '35',
      name: 'Travel Backpack',
      category: 'Accessories',
      price: 2799,
      rating: 4.8,
      image:
          'https://images.unsplash.com/photo-1622560480605-d83c853bc5c3',
      description:
          'Large travel backpack with multiple storage compartments.',
    ),
  ];
}

