import 'package:flutter/material.dart';
import 'package:uas/models/restaurant.dart';
import 'package:uas/models/menu.dart';
import 'package:uas/models/food.dart';
import 'package:uas/models/review.dart';
import 'package:uas/services/restaurant_service.dart';
import 'package:uas/screens/review/main_review.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:ui';
import 'package:uas/main.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    int userId = -1;
    if (request.getJsonData()['data']['id'] != null) {
      userId = request.getJsonData()['data']['id'];
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[800],
        title: const Text(
          'MANGAN" SOLO',
          style: TextStyle(
            fontFamily: 'Serif',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.brown[800],
      body: FutureBuilder<Map<String, dynamic>>(
        future: RestaurantService().fetchRestaurantDetails(restaurant.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            final data = snapshot.data!;
            final List<Menu> menus = data['menus'];
            final List<Food> foods = data['foods'];
            final List<Review> reviews = data['reviews'];

            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/batik.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.35),
                        BlendMode.dstATop,
                      )),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header Section
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Color(0xFF5D4037).withOpacity(0.8),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  restaurant.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.brown, Colors.black],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 4,
                                    ),
                                    color: Colors.brown[800],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  child: Image.network(
                                    restaurant.photoUrl.isNotEmpty
                                        ? getFullImageUrl(restaurant.photoUrl)
                                        : 'https://via.placeholder.com/400',
                                    height: 240,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // add a button to add to bookmark
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // Add your bookmark logic here
                                  },
                                  icon: const Icon(Icons.bookmark),
                                  label: const Text('Tambahkan ke Bookmark'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),
                              Text(
                                'Kategori Makanan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    spacing: 8,
                                    children: [
                                      ...menus.map((category) => Chip(
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            label: Text(
                                              category.category,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            backgroundColor: Colors.brown[900],
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Kawasan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                restaurant.district,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[300],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Alamat',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                restaurant.address,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[300],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Jam Operasional',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                restaurant.operationalHours,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Food Section
                    const SizedBox(height: 24),
                    Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 3.0,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...foods.take(3).map((food) => Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          color: Color(0xFF5D4037).withOpacity(0.8),
                          child: ListTile(
                            title: Text(
                              food.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              'Price: Rp.${food.price}',
                              style: TextStyle(color: Colors.grey[300]),
                            ),
                          ),
                        )),

                    // Reviews Section
                    const SizedBox(height: 24),
                    Text(
                      'Review',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 3.0,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...reviews.map((review) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        color: Color(0xFF5D4037).withOpacity(0.8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 8),
                            // Safely render images
                            if (review.fields.images != null &&
                                review.fields.images.isNotEmpty)
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: review.fields.images.length,
                                  itemBuilder: (context, index) {
                                    final imageUrl =
                                        review.fields.images[index];

                                    // Check if imageUrl is null
                                    if (imageUrl == null || imageUrl.isEmpty) {
                                      print(
                                          'Invalid image URL at index $index');
                                      return Container(
                                        alignment: Alignment.center,
                                        height: 150,
                                        width: 150,
                                        color: Colors.grey[800],
                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.grey,
                                        ),
                                      );
                                    }
                                    final validImageUrl =
                                        imageUrl.startsWith('http')
                                            ? imageUrl
                                            : '${CONSTANTS.baseUrl}/$imageUrl';

                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          validImageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              alignment: Alignment.center,
                                              height: 150,
                                              width: 150,
                                              color: Colors.grey[800],
                                              child: const Icon(
                                                Icons.broken_image,
                                                color: Colors.grey,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    review.fields.displayName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '"${review.fields.judulUlasan}"',
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    review.fields.teksUlasan,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        '${review.fields.penilaian}/5',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      IconButton(
                                        icon: Icon(
                                          Icons.thumb_up,
                                          color: review.fields.likes
                                                  .contains(userId.toString())
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        onPressed: () {
                                          if (review.fields.likes
                                              .contains(userId.toString())) {
                                            review.fields.likes
                                                .remove(userId.toString());
                                          } else {
                                            review.fields.likes
                                                .add(userId.toString());
                                          }
                                          print(
                                              'Like review ${review.pk}, user $userId like status: ${review.fields.likes}');
                                          RestaurantService()
                                              .likeReview(review.pk);
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Diterbitkan pada: ${review.fields.tanggal}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainReviewPage(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Buat Review'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
