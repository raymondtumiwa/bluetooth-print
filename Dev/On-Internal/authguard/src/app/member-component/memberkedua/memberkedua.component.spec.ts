import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MemberkeduaComponent } from './memberkedua.component';

describe('MemberkeduaComponent', () => {
  let component: MemberkeduaComponent;
  let fixture: ComponentFixture<MemberkeduaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MemberkeduaComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(MemberkeduaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
