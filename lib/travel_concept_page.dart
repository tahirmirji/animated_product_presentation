import 'package:flutter/material.dart';
import 'bike_concept_detail_page.dart';

const duration = Duration(milliseconds: 300);

class BikeConceptPage extends StatefulWidget {
  @override
  _BikeConceptPageState createState() => _BikeConceptPageState();
}

const backgroundColor = Color(0xFF8F9CAC);

class _BikeConceptPageState extends State<BikeConceptPage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor.withOpacity(0.5),
              backgroundColor,
            ],
          ),
        ),
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text('NextinGo'),
                  accountEmail: Text('ccount@gmail.com'),
                  currentAccountPicture: CircleAvatar(
                    child: Text('N'),
                    backgroundColor: Colors.white,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Profle'),
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('My Bikes'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notifications'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Animated Products '),
            actions: [
              IconButton(
                onPressed: () => null,
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: locations.length,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  controller: PageController(
                    viewportFraction: 0.7,
                  ),
                  itemBuilder: (_, index) => AnimatedOpacity(
                    duration: duration,
                    opacity: _currentPage == index ? 1.0 : 0.5,
                    child: BikeItem(
                      item: locations[index],
                      itemSelected: _currentPage == index,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '${_currentPage + 1}/${locations.length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BikeItem extends StatefulWidget {
  final bool itemSelected;
  final LocationCard item;

  const BikeItem({
    Key key,
    this.itemSelected,
    this.item,
  }) : super(key: key);

  @override
  _BikeItemState createState() => _BikeItemState();
}

class _BikeItemState extends State<BikeItem> {
  bool _selected = false;

  void _onTap() {
    if (_selected) {
      final page = BikeConceptDetailPage(
        location: widget.item,
      );
      Navigator.of(context).push(
        PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 700),
            pageBuilder: (_, animation1, __) => page,
            transitionsBuilder: (_, animation1, animation2, child) {
              return FadeTransition(
                opacity: animation1,
                child: child,
              );
            }),
      );
    } else {
      setState(() {
        _selected = !_selected;
      });
    }
  }

  void _onVerticalDrag(DragUpdateDetails details) {
    if (details.primaryDelta > 3.0) {
      setState(() {
        _selected = false;
      });
    }
  }

  Widget _buildStar({bool starSelected = true}) => Expanded(
        child: Icon(
          Icons.star,
          size: 20,
          color: starSelected ? Colors.orange : Colors.grey,
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (!widget.itemSelected) {
      _selected = false;
    }
    return LayoutBuilder(builder: (context, constraints) {
      final itemHeight =
          constraints.maxHeight * (widget.itemSelected ? 0.55 : 0.52);
      final itemWidth = constraints.maxWidth * 0.82;

      final borderRadius = BorderRadius.circular(5.0);
      final backWidth = _selected ? itemWidth * 1.2 : itemWidth;
      final backHeight = _selected ? itemHeight * 1.1 : itemHeight;
      return Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: _onTap,
          onVerticalDragUpdate: _onVerticalDrag,
          child: Stack(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: AnimatedContainer(
                    duration: duration,
                    height: backHeight,
                    width: backWidth,
                    color: Colors.white,
                    margin:
                        EdgeInsets.only(top: _selected ? itemHeight * 0.15 : 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.item.title,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Rs. ${widget.item.price}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _buildStar(),
                                    _buildStar(),
                                    _buildStar(),
                                    _buildStar(),
                                    _buildStar(
                                      starSelected: false,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 10.0),
                          child: Row(
                            children: avatars
                                .map(
                                  (f) => Align(
                                    widthFactor: 0.85,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(f),
                                      radius: 15,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: AnimatedContainer(
                    duration: duration,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 5.0),
                          spreadRadius: 5.0,
                        ),
                      ],
                    ),
                    height: itemHeight,
                    width: itemWidth,
                    margin: EdgeInsets.only(
                        bottom: _selected ? itemHeight * 0.5 : 0),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Hero(
                            tag: widget.item.title,
                            child: Image.network(
                              widget.item.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 50.0, right: 50.0),
                              decoration: BoxDecoration(
                                color: Colors.black45,
                              ),
                              child: Text(
                                widget.item.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class LocationCard {
  final String price;
  final String title;
  final String imageUrl;

  LocationCard({this.title, this.imageUrl, this.price});
}

List<LocationCard> locations = [
  LocationCard(
    price: '1,50,000',
    title: 'Ather',
    imageUrl:
        'https://bs-ather-jobs-assests.s3-ap-south-1.amazonaws.com/bpa-assests/mini-450x-referral-banner.png',
  ),
  LocationCard(
    price: '1,20,000',
    title: 'Chetak',
    imageUrl:
        'https://media.zigcdn.com/media/content/2019/Nov/chetak_thumb.jpg',
  ),
  LocationCard(
    price: '1,45,000',
    title: 'Revolt RV400',
    imageUrl:
        'https://images.carandbike.com/bike-images/large/revolt/rv400/revolt-rv400.jpg?v=9',
  ),
  LocationCard(
    price: '80,000',
    title: 'TVS iQube',
    imageUrl:
        'https://imgd.aeplcdn.com/1200x900/bw/models/tvs-iqube-standard20200125210025.jpg',
  ),
];

final avatars = [
  'https://randomuser.me/api/portraits/thumb/women/10.jpg',
  'https://randomuser.me/api/portraits/thumb/men/1.jpg',
  'https://randomuser.me/api/portraits/thumb/women/5.jpg',
  'https://randomuser.me/api/portraits/thumb/men/10.jpg',
];
