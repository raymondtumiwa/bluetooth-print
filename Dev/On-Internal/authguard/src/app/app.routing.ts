import { Routes } from '@angular/router';

import { FullComponent } from './layouts/full/full.component';
import { LoginComponent } from './login/login.component';
import { AuthGuard } from './auth.guard';

export const AppRoutes: Routes = [
    {
        path: '',
        component: FullComponent,
        canActivate: [AuthGuard],
        children: [
            {
                path: '',
                redirectTo: '/login',
                pathMatch: 'full'
            },
            
            {
                path: 'starter',
                loadChildren: () => import('./starter/starter.module').then(m => m.StarterModule)
            },
            {
                path: 'material',
                loadChildren: () => import('./material-component/material.module').then(m => m.MaterialComponentsModule)
            },
            {
                path: 'member',
                loadChildren: () => import('./member-component/member.module').then(m => m.MemberComponentModule)
            },
            {
                path: 'testing',
                loadChildren: () => import('./testing/testing.module').then(m => m.TestingModule)
            },
            {
                path: 'hr',
                loadChildren: () => import('./hr-component/hr.module').then(m=>m.HrComponentModule)
            }
            

        ]
    },
    {
        path: 'login',
        component: LoginComponent,
    },
];
