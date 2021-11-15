import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DeveloperInfoComponent } from './developer-info.component';

describe('DeveloperInfoComponent', () => {
  let component: DeveloperInfoComponent;
  let fixture: ComponentFixture<DeveloperInfoComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DeveloperInfoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DeveloperInfoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  // it('should create', () => {
  //   expect(component).toBeTruthy();
  // });
});
