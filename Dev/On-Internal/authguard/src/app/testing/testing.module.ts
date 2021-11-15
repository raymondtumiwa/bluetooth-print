import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { DemoMaterialModule } from '../demo-material-module';
import { FlexLayoutModule } from '@angular/flex-layout';
import { TestingComponent } from './testing.component';
import { TestingRoutes } from './testing.routing';

@NgModule({
  imports: [
    CommonModule,
    DemoMaterialModule,
    FlexLayoutModule,
    RouterModule.forChild(TestingRoutes)
  ],
  declarations: [TestingComponent]
})
export class TestingModule {}
