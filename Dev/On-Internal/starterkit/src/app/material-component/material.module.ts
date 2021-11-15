
import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';

import { DemoMaterialModule } from '../demo-material-module';
import { CdkTableModule } from '@angular/cdk/table';

import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { FlexLayoutModule } from '@angular/flex-layout';

import { MaterialRoutes } from './material.routing';
import { ButtonsComponent } from './buttons/buttons.component';
import { BadgeComponent } from './badge/badge.component';
import { CardsComponent } from './cards/cards.component';
import { GridComponent } from './grid/grid.component';
import { ListsComponent } from './lists/lists.component';
import { MenuComponent } from './menu/menu.component';
import { TabsComponent } from './tabs/tabs.component';
import { RipplesComponent } from './ripples/ripples.component';
import { StepperComponent } from './stepper/stepper.component';
import { ExpansionComponent } from './expansion/expansion.component';
import { ChipsComponent } from './chips/chips.component';
import { ToolbarComponent } from './toolbar/toolbar.component';
import { ProgressSnipperComponent } from './progress-snipper/progress-snipper.component';
import { ProgressComponent } from './progress/progress.component';
import {
    DialogComponent,
    DialogOverviewExampleDialogComponent
} from './dialog/dialog.component';
import { TooltipComponent } from './tooltip/tooltip.component';
import { SnackbarComponent } from './snackbar/snackbar.component';
import { SliderComponent } from './slider/slider.component';
import { SlideToggleComponent } from './slide-toggle/slide-toggle.component';

@NgModule({
    imports: [
        CommonModule,
        RouterModule.forChild(MaterialRoutes),
        DemoMaterialModule,
        FormsModule,
        ReactiveFormsModule,
        FlexLayoutModule,
        CdkTableModule
    ],
    providers: [
    ],
    entryComponents: [DialogOverviewExampleDialogComponent],
    declarations: [
        ButtonsComponent,
        BadgeComponent,
        CardsComponent,
        GridComponent,
        ListsComponent,
        MenuComponent,
        TabsComponent,
        RipplesComponent,
        StepperComponent,
        ExpansionComponent,
        ChipsComponent,
        ToolbarComponent,
        ProgressSnipperComponent,
        ProgressComponent,
        DialogComponent,
        DialogOverviewExampleDialogComponent,
        TooltipComponent,
        SnackbarComponent,
        SliderComponent,
        SlideToggleComponent
    ]
})
export class MaterialComponentsModule { }
