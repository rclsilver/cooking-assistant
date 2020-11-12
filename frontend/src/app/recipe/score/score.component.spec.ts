import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RecipeScoreComponent } from './score.component';

describe('ScoreComponent', () => {
  let component: RecipeScoreComponent;
  let fixture: ComponentFixture<RecipeScoreComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [RecipeScoreComponent],
    }).compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(RecipeScoreComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
