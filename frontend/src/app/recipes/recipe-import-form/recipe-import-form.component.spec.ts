import { ComponentFixture, TestBed } from '@angular/core/testing';
import { RecipeImportFormComponent } from './recipe-import-form.component';

describe('RecipeImportFormComponent', () => {
  let component: RecipeImportFormComponent;
  let fixture: ComponentFixture<RecipeImportFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RecipeImportFormComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(RecipeImportFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
