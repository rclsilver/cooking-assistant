import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RecipePlanningDialogComponent } from './recipe-planning-dialog.component';

describe('RecipePlanningDialogComponent', () => {
  let component: RecipePlanningDialogComponent;
  let fixture: ComponentFixture<RecipePlanningDialogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RecipePlanningDialogComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(RecipePlanningDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
