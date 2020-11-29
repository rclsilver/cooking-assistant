import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { WeeklyPlanningComponent } from './weekly-planning/weekly-planning.component';
import { RecipesModule } from '../recipes/recipes.module';
import { RecipeDialogComponent } from './recipe-dialog/recipe-dialog.component';
import { MatButtonModule } from '@angular/material/button';
import { RouterModule } from '@angular/router';
import { DateAdapter } from '@angular/material/core';
import { CustomDateAdapter } from 'src/app/planning/custom.date.adapter';

@NgModule({
  declarations: [WeeklyPlanningComponent, RecipeDialogComponent],
  imports: [
    CommonModule,
    RecipesModule,
    MatButtonModule,
    RouterModule
  ],
  providers: [
    {
      provide: DateAdapter,
      useClass: CustomDateAdapter
    }
  ]
})
export class PlanningModule { }
