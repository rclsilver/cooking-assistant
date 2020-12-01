import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RecipeIngredientFormDialogComponent } from './recipe-ingredient-form-dialog.component';

describe('RecipeIngredientFormDialogComponent', () => {
  let component: RecipeIngredientFormDialogComponent;
  let fixture: ComponentFixture<RecipeIngredientFormDialogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RecipeIngredientFormDialogComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(RecipeIngredientFormDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
