
import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { DemoMaterialModule } from '../demo-material-module';
import { FlexLayoutModule } from '@angular/flex-layout';
import { DashboardsRoutes } from './dashboards.routing';
import { ChartistModule } from 'ng-chartist';
import { ChartsModule } from 'ng2-charts';
import { NgApexchartsModule } from 'ng-apexcharts';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { Dashboard1Component } from './dashboard1/dashboard1.component';
import { Dashboard2Component } from './dashboard2/dashboard2.component';

import {
    TopCardComponent,
    SalesOverviewComponent,
    VisitorComponent,
    Visitor2Component,
    IncomeExpenssComponent,
    PostsComponent,
    NewsletterComponent,
    DeveloperInfoComponent,
    ActivityComponent,
    TopCard2Component,
    SalesPurchaseComponent,
    SalesYearlyComponent,
    ContactListComponent,
    CommentsComponent,
    MessageComponent
} from './dashboard-components';
import { DashboardEmpComponent } from './dashboard-components/dashboard-emp/dashboard-emp.component';
import { EmpDialogComponent } from './dashboard-components/dashboard-emp/emp-dialog/emp-dialog.component';


@NgModule({
    imports: [
        CommonModule,
        DemoMaterialModule,
        FlexLayoutModule,
        ChartistModule,
        ChartsModule,
        NgApexchartsModule,
        RouterModule.forChild(DashboardsRoutes),
        FormsModule,
        ReactiveFormsModule
    ],
    declarations: [
        Dashboard1Component,
        Dashboard2Component,
        TopCardComponent,
        SalesOverviewComponent,
        VisitorComponent,
        Visitor2Component,
        IncomeExpenssComponent,
        PostsComponent,
        NewsletterComponent,
        DeveloperInfoComponent,
        ActivityComponent,
        TopCard2Component,
        SalesPurchaseComponent,
        SalesYearlyComponent,
        ContactListComponent,
        CommentsComponent,
        MessageComponent,
        DashboardEmpComponent,
        EmpDialogComponent
    ],
    entryComponents: [
        EmpDialogComponent
    ]
})
export class DashboardsModule { }
