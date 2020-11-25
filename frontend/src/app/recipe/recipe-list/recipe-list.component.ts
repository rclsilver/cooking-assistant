import { Component, OnInit, Output } from '@angular/core';
import { faCalendarPlus, faClock, faTrash, IconDefinition } from '@fortawesome/free-solid-svg-icons';
import { Observable } from 'rxjs';
import { Recipe } from 'src/app/@models/recipe';
import { ApiService } from 'src/app/core/api.service';
import { AuthService } from 'src/app/core/auth.service';

@Component({
  selector: 'app-recipe-list',
  templateUrl: './recipe-list.component.html',
  styleUrls: ['./recipe-list.component.scss'],
})
export class RecipeListComponent implements OnInit {
  @Output() recipes: Array<Recipe> = [];

  @Output() canAddRecipe: Observable<boolean>;
  @Output() canDeleteRecipe: Observable<boolean>;
  @Output() canPlanRecipe: Observable<boolean>;

  @Output() deleteIcon: IconDefinition = faTrash;
  @Output() planningIcon: IconDefinition = faCalendarPlus;
  @Output() clockIcon: IconDefinition = faClock;

  constructor(
    protected readonly api: ApiService,
    protected readonly auth: AuthService
  ) {
    this.canAddRecipe = this.auth.canActivateProtectedRoutes$;
    this.canDeleteRecipe = this.auth.canActivateAdministrativeRoutes$;
    this.canPlanRecipe = this.auth.canActivateProtectedRoutes$;
  }

  ngOnInit(): void {
    this.api.getRecipes().subscribe(
      (recipes: Array<Recipe>) => {
        this.recipes = recipes;
      },
      (e: any) => {
        console.error('Error while loading recipes');
        console.error(e);
      }
    );
  }

  deleteRecipe(recipe: Recipe): void {
    this.api.deleteRecipe(recipe).subscribe(() => {
      this.recipes = this.recipes.filter((item) => item.id != recipe.id);
    });
  }
}
