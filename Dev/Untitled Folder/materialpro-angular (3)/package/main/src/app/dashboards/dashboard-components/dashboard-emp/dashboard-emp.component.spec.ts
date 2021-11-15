import { DatePipe } from '@angular/common';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';

import { DashboardEmpComponent } from './dashboard-emp.component';

describe('DashboardEmpComponent', () => {
  let component: DashboardEmpComponent;
  let fixture: ComponentFixture<DashboardEmpComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DashboardEmpComponent ],
      imports:[MatDialogModule],
      providers:[DatePipe]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DashboardEmpComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  // it('should create', () => {
  //   expect(component).toBeTruthy();
  // });
});
