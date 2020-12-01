import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Ingredient, Recipe, RecipeIngredient, Unit } from 'src/app/recipes/types';
import { ApiService } from 'src/app/shared/api.service';
import { SuccessDialogComponent } from 'src/app/shared/success-dialog/success-dialog.component';

@Component({
  templateUrl: './recipe-ingredient-form-dialog.component.html',
  styleUrls: ['./recipe-ingredient-form-dialog.component.scss'],
})
export class RecipeIngredientFormDialogComponent implements OnInit {
  form: FormGroup;
  ingredients: Ingredient[] = [];
  units: Unit[] = [];

  constructor(
    @Inject(MAT_DIALOG_DATA)
    public data: {
      recipe: Recipe;
      ingredient: RecipeIngredient | null;
    },
    private dialogRef: MatDialogRef<RecipeIngredientFormDialogComponent>,
    private api: ApiService,
    private formBuilder: FormBuilder,
    private dialog: MatDialog
  ) {
    this.form = this.formBuilder.group({
      ingredient_id: [this.data.ingredient?.ingredient ? this.data.ingredient.ingredient.id : null, [Validators.required]],
      optional: [this.data.ingredient ? this.data.ingredient.optional : false, [Validators.required]],
      quantity: [this.data.ingredient ? this.data.ingredient.quantity : null, []],
      unit_id: [this.data.ingredient?.unit ? this.data.ingredient.unit.id : null, []]
    });
  }

  ngOnInit(): void {
    this.api.getIngredients().then((ingredients: Ingredient[]) => this.ingredients = ingredients);
    this.api.getUnits().then((units: Unit[]) => (this.units = units));
  }

  cancel(): void {
    this.dialogRef.close();
  }

  submit(): void {
    const payload = Object.assign(
      {
        ingredient_id: this.data.ingredient?.ingredient ? this.data.ingredient.ingredient.id : null,
        optional: this.data.ingredient ? this.data.ingredient.optional : false,
        quantity: this.data.ingredient ? this.data.ingredient.optional : null,
        unit_id: this.data.ingredient?.unit ? this.data.ingredient.unit.id : null
      },
      this.form.value
    );
    const promise: Promise<RecipeIngredient> = this.data.ingredient
      ? this.api.updateRecipeIngredient(this.data.recipe, this.data.ingredient, payload)
      : this.api.addRecipeIngredient(this.data.recipe, payload);

    promise
      .then((ingredient: RecipeIngredient) => {
        this.dialog
          .open(SuccessDialogComponent, {
            data: {
              title: this.data.ingredient
                ? 'Ingredient update'
                : 'Ingredient adding',
              message: this.data.ingredient
                ? 'Ingredient has been updated successfully'
                : 'Ingredient has been added successfully',
            },
          })
          .afterClosed()
          .subscribe(() => this.dialogRef.close(ingredient));
      })
      .catch(this.api.handleFormError(this.form));
  }
}
