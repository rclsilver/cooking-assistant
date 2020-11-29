import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RecipeDialogComponent } from './recipe-dialog.component';

describe('RecipeModalComponent', () => {
  let component: RecipeDialogComponent;
  let fixture: ComponentFixture<RecipeDialogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RecipeDialogComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(RecipeDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
