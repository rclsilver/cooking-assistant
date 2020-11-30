import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatMenuModule } from '@angular/material/menu';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatTableModule } from '@angular/material/table';
import { RecipeListComponent } from './recipe-list/recipe-list.component';
import { RecipeImportFormComponent } from './recipe-import-form/recipe-import-form.component';
import { ReactiveFormsModule } from '@angular/forms';
import { RecipePlanningDialogComponent } from './recipe-planning-dialog/recipe-planning-dialog.component';
import { MatMomentDateModule } from '@angular/material-moment-adapter';
import { UnitListComponent } from './unit-list/unit-list.component';
import { UnitFormComponent } from './unit-form/unit-form.component';
import { IngredientListComponent } from './ingredient-list/ingredient-list.component';
import { IngredientFormComponent } from './ingredient-form/ingredient-form.component';
import { RecipeViewComponent } from './recipe-view/recipe-view.component';
import { RecipeCreateFormComponent } from './recipe-create-form/recipe-create-form.component';

@NgModule({
  declarations: [
    RecipeListComponent,
    RecipeCreateFormComponent,
    RecipeImportFormComponent,
    RecipePlanningDialogComponent,
    UnitListComponent,
    UnitFormComponent,
    IngredientListComponent,
    IngredientFormComponent,
    RecipeViewComponent,
    RecipeCreateFormComponent,
  ],
  imports: [
    CommonModule,
    RouterModule,
    MatCardModule,
    MatIconModule,
    MatButtonModule,
    MatFormFieldModule,
    MatInputModule,
    MatMenuModule,
    MatDatepickerModule,
    MatMomentDateModule,
    MatTableModule,
    MatMenuModule,
    ReactiveFormsModule,
  ],
})
export class RecipesModule { }
