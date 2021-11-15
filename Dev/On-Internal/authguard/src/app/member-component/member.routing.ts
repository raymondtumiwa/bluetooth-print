import { Routes } from '@angular/router';

import { MemberpertamaComponent } from './memberpertama/memberpertama.component';
import { MemberkeduaComponent } from './memberkedua/memberkedua.component'

export const MemberRoutes: Routes = [
    {
        path: '',
        children: [
            {
                path: 'memberpertama',
                component: MemberpertamaComponent,
                data: {
                    title: 'Memberpertama',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Buttons' }
                    ]
                }
            },
            {
                path: 'memberkedua',
                component: MemberkeduaComponent,
                data: {
                    title: 'Memberkedua',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Badge' }
                    ]
                }
            }
        ]
    }
];
