import 'package:flutter/material.dart';
import 'package:angel/common/colors/custom_colors.dart';
import 'package:angel/model/services_model.dart';

class Services extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildServices(context);
  }

  Widget _buildServices(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        addAutomaticKeepAlives: false,
        itemBuilder: (context, i) {
          return _buildService(
            context: context,
            service: servicesModel[i],
          );
        },
        itemCount: servicesModel.length,
      ),
    );
  }

  Widget _buildService({BuildContext context, ServicesModel service}) {
    return GestureDetector(
      child: Container(
        width: 135,
        height: 170,
        margin: EdgeInsets.only(top: 10, right: 20, bottom: 10),
        decoration: BoxDecoration(
          color: service.color,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: BaseColors.shadow,
              offset: Offset(4.0, 3.0),
              blurRadius: 7.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildServiceIcon(service),
            _buildServiceName(service),
            Icon(Icons.trending_flat, color: Colors.white),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/');
      },
    );
  }

  Widget _buildServiceIcon(ServicesModel service) {
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.only(top: 18, bottom: 15),
      decoration: BoxDecoration(
        color: BaseColors.welcomeBackground,
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Icon(
        service.icon,
        size: 35,
        color: service.color,
      ),
    );
  }

  Widget _buildServiceName(ServicesModel service) {
    return Text(
      '${service.name}',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: BaseColors.blackText,
      ),
    );
  }
}
