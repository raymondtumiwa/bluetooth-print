import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DatabaseEmployeeComponent } from './database-employee.component';

describe('DatabaseEmployeeComponent', () => {
  let component: DatabaseEmployeeComponent;
  let fixture: ComponentFixture<DatabaseEmployeeComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DatabaseEmployeeComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DatabaseEmployeeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
