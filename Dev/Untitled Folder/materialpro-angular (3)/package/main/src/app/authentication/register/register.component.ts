import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
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
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {
  public form: FormGroup = Object.create(null);
  constructor(private fb: FormBuilder, private router: Router) { }

  ngOnInit(): void {
    this.form = this.fb.group({
      email: [null, Validators.compose([Validators.required, CustomValidators.email])],
      // tslint:disable-next-line - Disables all
      password: password,
      // tslint:disable-next-line - Disables all
      confirmPassword: confirmPassword
    });
  }

  onSubmit(): void {
    this.router.navigate(['/']);
  }
}
