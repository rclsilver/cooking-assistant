import { Location } from '@angular/common';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { ApiService } from 'src/app/shared/api.service';
import { SuccessDialogComponent } from 'src/app/shared/success-dialog/success-dialog.component';
import { Recipe } from '../types';

@Component({
  selector: 'app-recipe-import-form',
  templateUrl: './recipe-import-form.component.html',
  styleUrls: ['./recipe-import-form.component.scss']
})
export class RecipeImportFormComponent {
  form: FormGroup;

  constructor(
    private formBuilder: FormBuilder,
    private api: ApiService,
    private dialog: MatDialog,
    private location: Location
  ) {
    let urlPattern: RegExp = /(^|\s)((https?:\/\/)?[\w-]+(\.[\w-]+)+\.?(:\d+)?(\/\S*)?)/gi;

    this.form = this.formBuilder.group({
      url: [null, [
        Validators.required,
        Validators.pattern(urlPattern)
      ]],
    });
  }

  cancel(): void {
    this.location.back();
  }

  submit(): void {
    this.api.importRecipe(this.form.value)
      .then((recipe: Recipe) => {
        this.dialog.open(SuccessDialogComponent, {
          data: {
            title: 'Recipe importation',
            message: 'Recipe has been imported successfully'
          }
        }).afterClosed().subscribe(() => this.location.back());
      })
      .catch(this.api.handleFormError(this.form));
  }
}
