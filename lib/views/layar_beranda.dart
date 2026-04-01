import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../api/api.dart';
import '../models/karakter.dart';
import 'layar_detail.dart';
import 'widgets/card_chart.dart';
import 'widgets/search.dart';

class LayarBeranda extends StatefulWidget {
  const LayarBeranda({super.key});

  @override
  State<LayarBeranda> createState() => _LayarBerandaState();
}

class _LayarBerandaState extends State<LayarBeranda> {
  final LayananApi _layananApi = LayananApi();
  final TextEditingController _searchController = TextEditingController();

  late Future<List<Karakter>> _charactersFuture;
  List<Karakter> _allCharacters = <Karakter>[];
  List<Karakter> _filteredCharacters = <Karakter>[];

  @override
  void initState() {
    super.initState();
    _charactersFuture = _loadCharacters();
  }

  Future<List<Karakter>> _loadCharacters() async {
    final List<Karakter> characters = await _layananApi.fetchCharacters();
    _allCharacters = characters;
    _applySearch(_searchController.text);
    return characters;
  }

  void _applySearch(String query) {
    final String keyword = query.trim().toLowerCase();
    setState(() {
      if (keyword.isEmpty) {
        _filteredCharacters = List<Karakter>.from(_allCharacters);
      } else {
        _filteredCharacters = _allCharacters
            .where(
              (character) => character.fullName.toLowerCase().contains(keyword),
            )
            .toList();
      }
    });
  }

  Future<void> _refreshCharacters() async {
    setState(() {
      _charactersFuture = _loadCharacters();
    });
    await _charactersFuture;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/Logo_Game_of_Thrones.png',
          height: 36,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: RefreshIndicator(
        color: const Color(0xFFD4AF37),
        backgroundColor: const Color(0xFF171717),
        onRefresh: _refreshCharacters,
        child: FutureBuilder<List<Karakter>>(
          future: _charactersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildShimmerLoading();
            }

            if (snapshot.hasError) {
              return ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  const SizedBox(height: 220),
                  Center(
                    child: Text(
                      'Terjadi error: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              );
            }

            if (_allCharacters.isEmpty) {
              return ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: const [
                  SizedBox(height: 220),
                  Center(
                    child: Text(
                      'Data karakter belum tersedia.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              );
            }

            return ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
              children: [
                const Text(
                  'Para Penguasa Game of Thrones',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.w800,
                    height: 1,
                    fontFamily: 'serif',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Legenda dan garis keturunan yang menentukan nasib Westeros.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                BilahPencarianKarakter(
                  controller: _searchController,
                  onChanged: _applySearch,
                ),
                const SizedBox(height: 16),
                if (_filteredCharacters.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'Karakter tidak ditemukan.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    itemCount: _filteredCharacters.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final Karakter character = _filteredCharacters[index];
                      return KartuKarakter(
                        character: character,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LayarDetail(character: character),
                            ),
                          );
                        },
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
      children: [
        Shimmer.fromColors(
          baseColor: const Color(0xFF1F1F1F),
          highlightColor: const Color(0xFF2A2A2A),
          child: Column(
            children: [
              Container(
                width: 280,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 320,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              const SizedBox(height: 16),
              ...List<Widget>.generate(
                4,
                (_) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF171717),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: const BoxDecoration(
                          color: Color(0xFF242424),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 180,
                              height: 22,
                              color: const Color(0xFF242424),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: 140,
                              height: 14,
                              color: const Color(0xFF242424),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 120,
                              height: 22,
                              decoration: BoxDecoration(
                                color: const Color(0xFF242424),
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
