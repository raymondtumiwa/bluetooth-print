import { Routes } from '@angular/router';

import { AutocompleteComponent } from './autocomplete/autocomplete.component';
import { CheckboxComponent } from './checkbox/checkbox.component';
import { RadiobuttonComponent } from './radiobutton/radiobutton.component';
import { FormfieldComponent } from './formfield/formfield.component';
import { DatepickerComponent } from './datepicker/datepicker.component';
import { FormLayoutComponent } from './form-layouts/form-layout.component';
import { PaginatiorComponent } from './paginator/paginator.component';
import { SortheaderComponent } from './sortheader/sortheader.component';
import { SelectfieldComponent } from './select/select.component';
import { InputfieldComponent } from './input/input.component';
import { EditorComponent } from './editor/editor.component';
import { FormValidationComponent } from './form-validation/form-validation.component';
import { WizardComponent } from './wizard/wizard.component';
import { MultiselectComponent } from './multiselect/multiselect.component';

export const FormRoutes: Routes = [
    {
        path: '',
        children: [
            {
                path: 'autocomplete',
                component: AutocompleteComponent,
                data: {
                    title: 'Autocomplete',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Autocomplete' }
                    ]
                }
            },
            {
                path: 'checkbox',
                component: CheckboxComponent,
                data: {
                    title: 'Checkbox',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Checkbox' }
                    ]
                }
            },
            {
                path: 'radiobutton',
                component: RadiobuttonComponent,
                data: {
                    title: 'Radio Buttons',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Radio Buttons' }
                    ]
                }
            },
            {
                path: 'datepicker',
                component: DatepickerComponent,
                data: {
                    title: 'Datepicker',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Datepicker' }
                    ]
                }
            },
            {
                path: 'formfield',
                component: FormfieldComponent,
                data: {
                    title: 'Form Filed',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Form Filed' }
                    ]
                }
            },
            {
                path: 'input',
                component: InputfieldComponent,
                data: {
                    title: 'Input Field',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Input Field' }
                    ]
                }
            },
            {
                path: 'select',
                component: SelectfieldComponent,
                data: {
                    title: 'Select',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Select' }
                    ]
                }
            },
            {
                path: 'paginator',
                component: PaginatiorComponent,
                data: {
                    title: 'Paginator',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Paginator' }
                    ]
                }
            },
            {
                path: 'form-layout',
                component: FormLayoutComponent,
                data: {
                    title: 'Form Layout',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Form Layout' }
                    ]
                }
            },
            {
                path: 'editor',
                component: EditorComponent,
                data: {
                    title: 'Form Editor',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Form Editor' }
                    ]
                }
            },
            {
                path: 'form-validation',
                component: FormValidationComponent,
                data: {
                    title: 'Form Validation',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Form Validation' }
                    ]
                }
            },
            {
                path: 'sortheader',
                component: SortheaderComponent,
                data: {
                    title: 'Sort Header',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Sort Header' }
                    ]
                }
            },
            {
                path: 'wizard',
                component: WizardComponent,
                data: {
                    title: 'Form Wizard',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Form Wizard' }
                    ]
                }
            },
            {
                path: 'multiselect',
                component: MultiselectComponent,
                data: {
                    title: 'Multiselect',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Multiselect' }
                    ]
                }
            }
        ]
    }
];
