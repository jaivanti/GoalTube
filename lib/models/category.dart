class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.rating = 0.0,
  });

  String title;
  int lessonCount;
  double rating;
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/courses/course1.png',
      title: 'Flutter Tutorial for Beginners',
      lessonCount: 24,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/courses/course2.png',
      title: 'Next.js & Contentful Tutorial',
      lessonCount: 22,
      rating: 4.6,
    ),
    Category(
      imagePath: 'assets/courses/course3.png',
      title: 'Material UI Tutorial',
      lessonCount: 24,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/courses/course4.png',
      title: 'Vue 3 with TypeScript Jump',
      lessonCount: 22,
      rating: 4.6,
    ),
  ];

  List<Category> createCategoryList(List<Map<String, dynamic>> course) {
    var listCategory = <Category>[];
    for (int i = 0; i < course.length; i++) {
      listCategory.add(Category(
        imagePath: course[i]["videos_data"][0]["thumbnailLink"],
        title: course[i]["courseName"],
        lessonCount: course[i]["videos_data"].length,
        rating: course[i]["rating"],
      ));
    }
    return listCategory;
  }

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/courses/course3.png',
      title: 'Material UI Tutorial',
      lessonCount: 12,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/courses/course4.png',
      title: 'Vue 3 with TypeScript Jump Start',
      lessonCount: 28,
      rating: 4.9,
    ),
    Category(
      imagePath: 'assets/courses/course5.png',
      title: 'BootStrap 5 Tutorial for Beginners',
      lessonCount: 12,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/courses/course6.png',
      title: 'Full Modern React Tutorial',
      lessonCount: 28,
      rating: 4.9,
    ),
    Category(
      imagePath: 'assets/courses/course1.png',
      title: 'Flutter Tutorial for Beginners',
      lessonCount: 28,
      rating: 4.9,
    ),
    Category(
      imagePath: 'assets/courses/course2.png',
      title: 'Next.js & Contentful Tutorial',
      lessonCount: 28,
      rating: 4.9,
    ),
  ];
}
