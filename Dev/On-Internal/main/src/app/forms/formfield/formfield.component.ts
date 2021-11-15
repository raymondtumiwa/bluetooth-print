import { Component } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  Validators,
  FormControl
} from '@angular/forms';

@Component({
  selector: 'app-formfield',
  templateUrl: './formfield.component.html',
  styleUrls: ['./formfield.component.scss']
})
export class FormfieldComponent {
  options: FormGroup;

  hide = true;

  constructor(fb: FormBuilder) {
    this.options = fb.group({
      hideRequired: false,
      floatLabel: 'auto',
      color: 'primary',
      fontSize: [16, Validators.min(10)]
    });
  }

  email = new FormControl('', [Validators.required, Validators.email]);

  getErrorMessage(): any {
    return this.email.hasError('required')
      ? 'You must enter a value'
      : this.email.hasError('email')
        ? 'Not a valid email'
        : '';
  }

  getFontSize(): any {
    return Math.max(10, this.options.value.fontSize);
  }
}
