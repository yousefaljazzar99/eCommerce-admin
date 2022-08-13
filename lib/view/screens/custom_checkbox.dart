import 'package:flutter/material.dart';

class CustomCheckbox extends FormField<bool> {
  CustomCheckbox({
    FormFieldValidator<bool>? validator,
  }) : super(
            validator: validator,
            initialValue: false,
            builder: (State) {
              return CheckboxListTile(
                  title: const Text('جميع البيانات المدخلة صحيحة'),
                  subtitle: State.hasError
                      ? Text(State.errorText ?? '',
                          style: const TextStyle(color: Colors.red))
                      : const SizedBox(),
                  value: State.value,
                  onChanged: (v) {
                    State.didChange(v);
                  });
            });
}
