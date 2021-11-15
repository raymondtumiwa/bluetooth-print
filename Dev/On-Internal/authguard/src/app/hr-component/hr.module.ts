
import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';

import { DemoMaterialModule } from '../demo-material-module';
import { CdkTableModule } from '@angular/cdk/table';

import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { FlexLayoutModule } from '@angular/flex-layout';

import { hrRoutes } from './hr.routing';
import { EmployeeRegistrationComponent } from './employee-registration/employee-registration.component';
import { EmployeeManagementComponent } from './employee-management/employee-management.component';
import { AttendanceComponent } from './attendance/attendance.component';
import { HrParameterComponent } from './hr-parameter/hr-parameter.component';
import { BirthdayComponent } from './birthday/birthday.component';
import { LeaveComponent } from './leave/leave.component';
import { DatabaseEmployeeComponent } from './employee-management/database-employee/database-employee.component';
import { EmployeeListComponent } from './employee-management/employee-list/employee-list.component';
import { EmployeeGuestComponent } from './employee-management/employee-guest/employee-guest.component';

@NgModule({
    imports: [
        CommonModule,
        RouterModule.forChild(hrRoutes),
        DemoMaterialModule,
        FormsModule,
        ReactiveFormsModule,
        FlexLayoutModule,
        CdkTableModule
    ],
    providers: [
    ],
    declarations: [
        EmployeeRegistrationComponent,
        EmployeeManagementComponent,
        EmployeeGuestComponent,
        EmployeeListComponent,
        DatabaseEmployeeComponent,
        AttendanceComponent,
        HrParameterComponent,
        BirthdayComponent,
        LeaveComponent,
        


    ]
})
export class HrComponentModule { }
