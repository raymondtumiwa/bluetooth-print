import { Routes } from '@angular/router';

import { EmployeeRegistrationComponent } from './employee-registration/employee-registration.component';
import { EmployeeManagementComponent } from './employee-management/employee-management.component';
import { AttendanceComponent } from './attendance/attendance.component';
import { HrParameterComponent } from './hr-parameter/hr-parameter.component';
import { BirthdayComponent } from './birthday/birthday.component';
import { LeaveComponent } from './leave/leave.component';

export const hrRoutes: Routes = [
    {
        path: '',
        children: [
            {
                path: 'employeeRegistration',
                component: EmployeeRegistrationComponent,
                data: {
                    title: 'EmployeeRegistration',
                    
                }
            },
            {
                path: 'employeeManagement',
                component: EmployeeManagementComponent,
                data: {
                    title: 'EmployeeManagement',
                }
            },
            {
                path: 'hrParameter',
                component: HrParameterComponent,
                data: {
                    title: 'HrParameter',
                }
            },
            {
                path: 'attendance',
                component: AttendanceComponent,
                data: {
                    title: 'attendance',
                }
            },
            {
                path: 'birthday',
                component: BirthdayComponent,
                data: {
                    title: 'birthday',
                }
            },
            {
                path: 'leave',
                component: LeaveComponent,
                data: {
                    title: 'leave',
                }
            },
        ]
    }
];
