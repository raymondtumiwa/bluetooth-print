import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EmployeeGuestComponent } from './employee-guest.component';

describe('EmployeeGuestComponent', () => {
  let component: EmployeeGuestComponent;
  let fixture: ComponentFixture<EmployeeGuestComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ EmployeeGuestComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(EmployeeGuestComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
