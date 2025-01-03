import 'package:flutter/material.dart';
import 'package:uas/models/restaurant.dart';
import 'package:uas/models/review.dart';
import 'package:uas/services/restaurant_service.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Judul Review",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ac massa vehicula.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              "DELYA",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      color: Colors.brown[700],
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white70, width: 2.5),
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.dstATop,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Selamat Datang di Mangan" Solo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Makanan Lezat Menanti Anda!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  // Define your action here
                },
                child: const Text('Pelajari Lebih Lanjut'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TahukahAndaCard extends StatelessWidget {
  const TahukahAndaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      color: Colors.brown[700],
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white70, width: 2.5),
            borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.all(16),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image(image: AssetImage('assets/images/logo.png'), height: 100),
            Text(
              'Tahukah Anda?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Solo memiliki beragam kuliner khas yang lezat dan ramah di kantong! '
              'Dari Nasi Liwet hingga camilan tradisional, banyak hidangan bisa dinikmati '
              'mulai dari Rp10.000 saja. Cocok untuk Anda yang ingin mencicipi rasa lokal tanpa '
              'perlu keluar banyak biaya!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantReviewCard extends StatelessWidget {
  final Restaurant restaurant;
  final Review review;

  const RestaurantReviewCard({
    super.key,
    required this.restaurant,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.brown[600]?.withOpacity(0.8),
        elevation: 4,
        margin: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white70, width: 2.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Restaurant Section
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.network(
                  restaurant.photoUrl.isNotEmpty
                      ? getFullImageUrl(restaurant.photoUrl)
                      : 'https://via.placeholder.com/150',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Review Section
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.brown[600]?.withOpacity(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Apa Kata Mereka Tentang Restoran "${restaurant.name}"?',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.orange),
                        const SizedBox(width: 8),
                        Text(
                          review.fields.displayName,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '"${review.fields.judulUlasan}"',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      review.fields.teksUlasan,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.thumb_up,
                            size: 16, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          '${review.fields.likes} Likes',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.star, size: 16, color: Colors.orange),
                        const SizedBox(width: 4),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Diterbitkan pada: ${review.fields.tanggal}',
                      style:
                          const TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
