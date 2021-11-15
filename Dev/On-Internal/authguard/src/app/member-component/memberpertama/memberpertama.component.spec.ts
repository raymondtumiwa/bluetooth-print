import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MemberpertamaComponent } from './memberpertama.component';

describe('MemberpertamaComponent', () => {
  let component: MemberpertamaComponent;
  let fixture: ComponentFixture<MemberpertamaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MemberpertamaComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(MemberpertamaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
