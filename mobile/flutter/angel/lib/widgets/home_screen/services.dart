import 'package:angel/widgets/service_icon.dart';
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
      height: 180.0,
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
        width: 135.0,
        height: 170.0,
        margin: EdgeInsets.only(top: 10.0, right: 20.0, bottom: 10.0),
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
            ServiceIcon(icon: service.icon, color: service.color),
            _buildServiceName(service),
            Icon(Icons.trending_flat, color: Colors.white),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/services');
      },
    );
  }

  Widget _buildServiceName(ServicesModel service) {
    return Text(
      '${service.name}',
      style: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        color: BaseColors.blackText,
      ),
    );
  }
}
