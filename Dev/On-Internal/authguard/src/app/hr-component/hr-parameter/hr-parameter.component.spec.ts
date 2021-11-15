import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HrParameterComponent } from './hr-parameter.component';

describe('HrParameterComponent', () => {
  let component: HrParameterComponent;
  let fixture: ComponentFixture<HrParameterComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ HrParameterComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(HrParameterComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
