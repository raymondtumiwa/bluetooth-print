import { Routes } from '@angular/router';

import { ButtonsComponent } from './buttons/buttons.component';
import { BadgeComponent } from './badge/badge.component';
import { CardsComponent } from './cards/cards.component';
import { GridComponent } from './grid/grid.component';
import { ListsComponent } from './lists/lists.component';
import { MenuComponent } from './menu/menu.component';
import { TabsComponent } from './tabs/tabs.component';
import { StepperComponent } from './stepper/stepper.component';
import { ExpansionComponent } from './expansion/expansion.component';
import { ChipsComponent } from './chips/chips.component';
import { ToolbarComponent } from './toolbar/toolbar.component';
import { ProgressSnipperComponent } from './progress-snipper/progress-snipper.component';
import { ProgressComponent } from './progress/progress.component';
import { RipplesComponent } from './ripples/ripples.component';
import { DialogComponent } from './dialog/dialog.component';
import { TooltipComponent } from './tooltip/tooltip.component';
import { SnackbarComponent } from './snackbar/snackbar.component';
import { SliderComponent } from './slider/slider.component';
import { SlideToggleComponent } from './slide-toggle/slide-toggle.component';

export const MaterialRoutes: Routes = [
    {
        path: '',
        children: [
            {
                path: 'button',
                component: ButtonsComponent,
                data: {
                    title: 'Buttons',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Buttons' }
                    ]
                }
            },
            {
                path: 'badge',
                component: BadgeComponent,
                data: {
                    title: 'Badge',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Badge' }
                    ]
                }
            },
            {
                path: 'cards',
                component: CardsComponent,
                data: {
                    title: 'Cards',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Cards' }
                    ]
                }
            },
            {
                path: 'grid',
                component: GridComponent,
                data: {
                    title: 'Grids',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Grids' }
                    ]
                }
            },
            {
                path: 'lists',
                component: ListsComponent,
                data: {
                    title: 'Lists',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Lists' }
                    ]
                }
            },
            {
                path: 'menu',
                component: MenuComponent,
                data: {
                    title: 'Menu',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Menu' }
                    ]
                }
            },
            {
                path: 'tabs',
                component: TabsComponent,
                data: {
                    title: 'Tabs',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Tabs' }
                    ]
                }
            },
            {
                path: 'ripples',
                component: RipplesComponent,
                data: {
                    title: 'Ripples',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Ripples' }
                    ]
                }
            },
            {
                path: 'stepper',
                component: StepperComponent,
                data: {
                    title: 'Stepper',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Stepper' }
                    ]
                }
            },
            {
                path: 'expansion',
                component: ExpansionComponent,
                data: {
                    title: 'Expansion',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Expansion' }
                    ]
                }
            },
            {
                path: 'chips',
                component: ChipsComponent,
                data: {
                    title: 'Chips',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Chips' }
                    ]
                }
            },
            {
                path: 'toolbar',
                component: ToolbarComponent,
                data: {
                    title: 'Toolbar',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Toolbar' }
                    ]
                }
            },
            {
                path: 'progress-snipper',
                component: ProgressSnipperComponent,
                data: {
                    title: 'Progress Snipper',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Progress Snipper' }
                    ]
                }
            },
            {
                path: 'progress',
                component: ProgressComponent,
                data: {
                    title: 'Progress',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Progress' }
                    ]
                }
            },
            {
                path: 'dialog',
                component: DialogComponent,
                data: {
                    title: 'Dialog',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Dialog' }
                    ]
                }
            },
            {
                path: 'tooltip',
                component: TooltipComponent,
                data: {
                    title: 'Tooltip',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Tooltip' }
                    ]
                }
            },
            {
                path: 'snackbar',
                component: SnackbarComponent,
                data: {
                    title: 'Snackbar',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Snackbar' }
                    ]
                }
            },
            {
                path: 'slider',
                component: SliderComponent,
                data: {
                    title: 'Slider',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Slider' }
                    ]
                }
            },
            {
                path: 'slide-toggle',
                component: SlideToggleComponent,
                data: {
                    title: 'Slide Toggle',
                    urls: [
                        { title: 'Dashboard', url: '/dashboard' },
                        { title: 'Slide Toggle' }
                    ]
                }
            }
        ]
    }
];
