import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EmployeeManagementComponent } from './employee-management.component';

describe('EmployeeManagementComponent', () => {
  let component: EmployeeManagementComponent;
  let fixture: ComponentFixture<EmployeeManagementComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ EmployeeManagementComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(EmployeeManagementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
