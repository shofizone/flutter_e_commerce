import 'package:e_commerce_flutter/util/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'login_page.dart';

class RegisterPage extends StatefulWidget{

  RegisterPageState createState()=> RegisterPageState();



}

class RegisterPageState extends State<RegisterPage>{
  final _formKey = GlobalKey<FormState>();
  final _scaffolddKey = GlobalKey<ScaffoldState>();
  bool isSubmitting=false, _obscureValue = true;


  String _username,_email,_password;

  Widget _buildTitle ()  {
  return Text("Register", style: Theme.of(context).textTheme.headline,);
}
Widget _buildUserName(){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        onSaved: (val)=>_username = val,
        validator: (value)=> value.length < 6 ? "Username is Short" : null,
        decoration: InputDecoration(
            labelText: "Username",
            hintText: "Enter user name - At least 6 charecters",
            border: OutlineInputBorder(),
            icon: Icon(Icons.face,color: Colors.grey,)
        ),
      ),
    );
}
  Widget _buildEmail(){
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: TextFormField(
          onSaved: (val)=>_email = val,
          validator: (value)=> !value.contains("@")  ? "Invalid Email" : null,
          decoration: InputDecoration(
              labelText: "Email",
              hintText: "eg. jhon@example.com",
              border: OutlineInputBorder(),
              icon: Icon(Icons.mail,color: Colors.grey,)
          ),
        ),
      );

  }
Widget _buildPassword(){
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: TextFormField(
          onSaved: (val)=>_password = val,
          validator: (value)=> value.length < 6 ? "Username is Short" : null,
          obscureText: _obscureValue,
          decoration: InputDecoration(
            suffixIcon: IconButton(icon: Icon(_obscureValue? Icons.visibility:Icons.visibility_off), onPressed: (){

              setState(() {
                _obscureValue =  !_obscureValue;
              });
            }),
              labelText: "Password",
              hintText: "At least 6 charecters",
              border: OutlineInputBorder(),
              icon: Icon(Icons.lock,color: Colors.grey,)
          ),
        ),
      );
}
Widget _buildButtons(){
    return  Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          isSubmitting?CircularProgressIndicator( valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor,),):RaisedButton(
            onPressed: _handleSubmit,
            child: Text("Register",style: Theme.of(context).textTheme.body1,),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
            color: Theme.of(context).primaryColor,
          ),
          FlatButton(
            child: Text('Already have account? Login'),
              onPressed: ()=>Navigator.pushReplacementNamed(context, "/login")
          ),
        ],
      ),
    );
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffolddKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Register"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal:20 ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
              _buildTitle(),
                _buildUserName(),
                  _buildEmail(),
                  _buildPassword(),
                  _buildButtons(),


                ],
              ),
            ),
            ),
          ),
        ),
    );
  }


  void _handleSubmit(){
    final form = _formKey.currentState;

    if(form.validate()){
      form.save();
      registerUser();
      print("Username: " +_username + " Email: "+_email);
    }
  }

  void registerUser() async{
    setState(() {
      isSubmitting = true;
    });
    http.Response response = await authHelper.register(_username,_email,_password);
    var responseData = json.decode(response.body);
    if(response.statusCode == 200){

      setState(() {isSubmitting = false;});
      authHelper.storeUserData(responseData);
      _showSnackBar("User: $_username registration is successful",color: Colors.green);
      _navigateToHomePage();
    }else{
      setState(() { isSubmitting = false;});
      final String errorMessage = responseData["message"];
      _showSnackBar(errorMessage);
      throw Exception("Error Registering: $errorMessage");
    }




  }

  _navigateToHomePage(){
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, "/");
    });
  }

  _showSnackBar(String content,{Color color}){
    final snackbar = SnackBar(
      backgroundColor: color?? Colors.red,
      content:
      Text(content,textAlign: TextAlign.center,style: Theme.of(context).textTheme.body1,),
    );
 _scaffolddKey.currentState.showSnackBar(snackbar);
 _formKey.currentState.reset();

  }
}
