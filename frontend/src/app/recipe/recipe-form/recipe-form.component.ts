import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { ServerErrorResponse } from 'src/app/@models/error';
import { Recipe } from 'src/app/@models/recipe';
import { ApiService } from 'src/app/core/api.service';

@Component({
  selector: 'app-add-form',
  templateUrl: './recipe-form.component.html',
  styleUrls: ['./recipe-form.component.scss'],
})
export class RecipeFormComponent implements OnInit {
  form: FormGroup;

  constructor(
    protected readonly api: ApiService,
    protected readonly router: Router
  ) {
    this.form = new FormGroup({
      url: new FormControl('', [Validators.required]),
    });
  }

  ngOnInit(): void {}

  onSubmit(): void {
    var recipe = new Recipe();
    recipe.url = this.form.value.url;

    this.api.createRecipe(recipe).subscribe(
      (recipe: Recipe) => {
        this.router.navigate(['recipes']);
      },
      (e: any) => {
        if (e.status == 422 || e.status == 409) {
          let response: ServerErrorResponse = e.error;

          response.detail.forEach((error) => {
            this.form.controls[error.loc[1]].setErrors({
              server: error.msg,
            });
          });
        }
      }
    );
  }
}
