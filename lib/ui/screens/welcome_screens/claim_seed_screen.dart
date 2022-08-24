import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lavie/helper/bloc/address/address_cubit.dart';
import 'package:lavie/shared/components/default_form_field.dart';

class ClaimSeedScreen extends StatelessWidget {
  ClaimSeedScreen({Key? key}) : super(key: key);
  final address = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: AppBar(
            backgroundColor: Colors.white,
          ),
        ),
        body: BlocProvider(
          create: (context) => AddressCubit(),
          child: BlocListener<AddressCubit, AddressState>(
            listener: (context, state) {
              if (state is AddressSentSuccessful) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.response.message!),
                  ),
                );
                Navigator.pushReplacementNamed(context, '/home');
              } else if (state is AddressSentError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.response.message!),
                  ),
                );
              }
            },
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: SvgPicture.asset('assets/images/logo.svg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:
                      SvgPicture.asset('assets/fonts/Get Seeds For Free.svg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:
                      SvgPicture.asset('assets/fonts/Enter your Address.svg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: defaultTextFormField(
                      label: 'Address',
                      controller: address,
                      validate: (value) {
                        if (value == null) return "address can't be null";
                        return null;
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0),
                  child: MaterialButton(
                    onPressed: () {
                      context.read<AddressCubit>().sendRequest(address.text);
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    textColor: Colors.white,
                    color: const Color(0xff1ABC00),
                    minWidth: double.infinity,
                    height: 40,
                    child: const Text('Send'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 10),
                  child: MaterialButton(
                    onPressed: () async {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    textColor: Colors.white,
                    color: const Color(0xffF0F0F0),
                    minWidth: double.infinity,
                    height: 40,
                    child: const Text(
                      'Save For Later',
                      style: TextStyle(color: Color(0xff979797)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
