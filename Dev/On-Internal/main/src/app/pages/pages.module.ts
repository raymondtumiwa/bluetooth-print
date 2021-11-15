
import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { DemoMaterialModule } from '../demo-material-module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { FlexLayoutModule } from '@angular/flex-layout';
import { PagesRoutes } from './pages.routing';
import { NgxDatatableModule } from '@swimlane/ngx-datatable';
import {MatListModule} from '@angular/material/list';
import { MatIconComponent } from './material-icons/mat-icon.component';
import { TimelineComponent } from './timeline/timeline.component';
import { InvoiceComponent } from './invoice/invoice.component';
import { PricingComponent } from './pricing/pricing.component';
import { HelperComponent } from './helper-classes/helper.component';
@NgModule({
  imports: [
    CommonModule,
    RouterModule.forChild(PagesRoutes),
    DemoMaterialModule,
    FlexLayoutModule,
    FormsModule,
    MatListModule,
    ReactiveFormsModule,
    NgxDatatableModule
  ],
  declarations: [
    MatIconComponent,
    TimelineComponent,
    InvoiceComponent,
    PricingComponent,
    HelperComponent
  ]
})
export class PagesModule {}
