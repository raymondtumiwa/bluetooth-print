import 'hammerjs';
import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { DemoMaterialModule } from '../../demo-material-module';
import { CdkTableModule } from '@angular/cdk/table';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { FlexLayoutModule } from '@angular/flex-layout';
import { NgMultiSelectDropDownModule } from 'ng-multiselect-dropdown';
import { QuillModule } from 'ngx-quill';
import { MatDatepickerModule } from '@angular/material/datepicker';

import { EmployeeManagementRoutes } from './employee-management.routing';
import { MatSortModule } from '@angular/material/sort';

@NgModule({
    imports: [
        CommonModule,
        DemoMaterialModule,
        FormsModule,
        ReactiveFormsModule,
        FlexLayoutModule,
        CdkTableModule,
        MatDatepickerModule,
        NgMultiSelectDropDownModule.forRoot(),
        QuillModule.forRoot(),
        RouterModule.forChild(EmployeeManagementRoutes),
        MatSortModule
    ],
    exports: [MatSortModule],
    declarations: [
    ]
})
export class HybridModule { }
