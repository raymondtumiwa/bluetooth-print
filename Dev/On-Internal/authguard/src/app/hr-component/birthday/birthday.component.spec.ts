import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BirthdayComponent } from './birthday.component';

describe('BirthdayComponent', () => {
  let component: BirthdayComponent;
  let fixture: ComponentFixture<BirthdayComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ BirthdayComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BirthdayComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
