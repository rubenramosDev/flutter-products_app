import 'package:flutter/material.dart';
import 'package:productsapp/src/blocs/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _creatingBackground(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _creatingBackground(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    final purpleContainer = Container(
      height: sizes.height * 0.40,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0),
      ])),
    );

    final circles = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: [
        purpleContainer,
        Positioned(top: 90.0, left: 30.0, child: circles),
        Positioned(top: -40.0, right: -30.0, child: circles),
        Positioned(bottom: -50.0, right: -10.0, child: circles),
        Positioned(top: 120.0, right: 90.0, child: circles),
        Container(
          padding: EdgeInsets.only(top: 75.0),
          child: Column(
            children: [
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text(
                'Rubén Ramos',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = InheritedWidgetLogicBlocProvider.of(context);
    final sizes = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(height: 180.0),
          ),
          Container(
            width: sizes.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 35.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0,
                  )
                ]),
            child: Column(
              children: [
                Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _creatingEmail(bloc),
                SizedBox(height: 30.0),
                _creatingPassword(bloc),
                SizedBox(height: 30.0),
                _creatingButton(bloc)
              ],
            ),
          ),
          Text('¿Olvidó la contraseña?'),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _creatingEmail(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electronico',
                //errorText: 'Invalid email',
                counterText: snapshot.data,
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.deepPurple,
                ),
              ),
              onChanged: (value) => bloc.onChangeEmail(value),
            ),
          );
        });
  }

  Widget _creatingPassword(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: '*******',
                labelText: 'Password',
                errorText: snapshot.error,
                errorMaxLines: 2,
                icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                counterText: snapshot.data,
              ),
              onChanged: (value) => bloc.onChangePassword(value),
            ),
          );
        });
  }

  Widget _creatingButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          onPressed: snapshot.hasData ? () => _login(context, bloc) : null,
          elevation: 1.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
            child: Text('Ingresar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        );
      },
    );
  }

  _login(BuildContext context, LoginBloc bloc) {
    Navigator.pushReplacementNamed(context, 'home');
  }
}
