import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RecipeCreateFormComponent } from './recipe-create-form.component';

describe('RecipeCreateFormComponent', () => {
  let component: RecipeCreateFormComponent;
  let fixture: ComponentFixture<RecipeCreateFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RecipeCreateFormComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(RecipeCreateFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
