import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RecipeStepFormDialogComponent } from './recipe-step-form-dialog.component';

describe('RecipeStepFormComponent', () => {
  let component: RecipeStepFormDialogComponent;
  let fixture: ComponentFixture<RecipeStepFormDialogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RecipeStepFormDialogComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(RecipeStepFormDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
