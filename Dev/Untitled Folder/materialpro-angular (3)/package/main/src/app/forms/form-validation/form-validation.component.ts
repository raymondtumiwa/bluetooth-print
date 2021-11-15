import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  Validators,
  FormControl
} from '@angular/forms';
import { CustomValidators } from 'ngx-custom-validators';

const password = new FormControl('', Validators.required);
const confirmPassword = new FormControl('', CustomValidators.equalTo(password));

@Component({
  selector: 'app-form-validation',
  templateUrl: './form-validation.component.html',
  styleUrls: ['./form-validation.component.scss']
})
export class FormValidationComponent implements OnInit {
  public form: FormGroup = Object.create(null);

  constructor(private fb: FormBuilder) { }

  ngOnInit(): void {
    this.form = this.fb.group({
      fname: [
        null,
        Validators.compose([
          Validators.required,
          Validators.minLength(5),
          Validators.maxLength(10)
        ])
      ],
      email: [
        null,
        Validators.compose([Validators.required, CustomValidators.email])
      ],
      range: [
        null,
        Validators.compose([
          Validators.required,
          CustomValidators.range([5, 9])
        ])
      ],
      url: [
        null,
        Validators.compose([Validators.required, CustomValidators.url])
      ],
      date: [
        null,
        Validators.compose([Validators.required, CustomValidators.date])
      ],
      phone: [
        null,
        Validators.compose([Validators.required])
      ],
      gender: [null, Validators.required],
      // tslint:disable-next-line - Disables all
      password: password,
      // tslint:disable-next-line - Disables all
      confirmPassword: confirmPassword
    });
  }
}
