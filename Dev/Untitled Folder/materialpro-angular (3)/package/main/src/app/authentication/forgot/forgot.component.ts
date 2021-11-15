import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import {
  FormBuilder,
  FormGroup,
  Validators,
  FormControl
} from '@angular/forms';
import { CustomValidators } from 'ngx-custom-validators';


@Component({
  selector: 'app-forgot',
  templateUrl: './forgot.component.html',
  styleUrls: ['./forgot.component.scss']
})
export class ForgotComponent implements OnInit {
  public form: FormGroup = Object.create(null);
  constructor(private fb: FormBuilder, private router: Router) { }

  ngOnInit(): void {
    this.form = this.fb.group({
      email: [
        null,
        Validators.compose([Validators.required, CustomValidators.email])
      ]
    });
  }

  onSubmit(): void {
    this.router.navigate(['/authentication/login']);
  }
}
