import { Routes } from '@angular/router';

import { DynamictreeComponent } from './dynamic-tree/dynamic-tree.component';
import { FlattreeComponent } from './flat-tree/flat-tree.component';
import { LoadtreeComponent } from './load-tree/load-tree.component';
import { NestedtreeComponent } from './nested-tree/nested-tree.component';

export const TreeRoutes: Routes = [
    {
        path: '',
        children: [
            {
                path: 'dynamic-tree',
                component: DynamictreeComponent,
                data: {
                    title: 'Dynamic Data with tree',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Dynamic Data with tree' }
                    ]
                }
            },
            {
                path: 'flat-tree',
                component: FlattreeComponent,
                data: {
                    title: 'Flat Data with Tree',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Flat Data with Tree' }
                    ]
                }
            },
            {
                path: 'load-tree',
                component: LoadtreeComponent,
                data: {
                    title: 'Loaded Data with Tree',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Loaded Data with Tree' }
                    ]
                }
            },
            {
                path: 'nested-tree',
                component: NestedtreeComponent,
                data: {
                    title: 'Nested Tree',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Nested Tree' }
                    ]
                }
            }
        ]
    }
];
