import 'package:flutter/material.dart';
import 'package:angel/common/colors/custom_colors.dart';
import 'package:angel/model/categories_model.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildCategories(context);
  }

  Widget _buildCategories(BuildContext context) {
    return Container(
      height: 180,
      padding: EdgeInsets.only(top: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        addAutomaticKeepAlives: false,
        itemBuilder: (context, i) {
          return _buildCategory(
            context: context,
            category: categoriesModel[i],
          );
        },
        itemCount: categoriesModel.length,
      ),
    );
  }

  Widget _buildCategory({BuildContext context, CategoriesModel category}) {
    return GestureDetector(
      child: Container(
        width: 250,
        margin: EdgeInsets.only(right: 20, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              blurRadius: 7.0,
              color: BaseColors.welcomeBackground,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCategoryImage(category: category),
            _buildCategoryNameAndRate(category: category),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/');
      },
    );
  }

  Widget _buildCategoryImage({CategoriesModel category}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/categories/${category.image}'),
          fit: BoxFit.cover,
        ),
      ),
      height: 110.0,
    );
  }

  Widget _buildCategoryNameAndRate({CategoriesModel category}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '${category.name}',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${category.rate}',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: BaseColors.subText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
