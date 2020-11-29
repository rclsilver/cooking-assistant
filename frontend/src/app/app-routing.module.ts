import { NgModule } from '@angular/core';
import { Routes, RouterModule, ExtraOptions } from '@angular/router';
import { RecipeListComponent } from './recipes/recipe-list/recipe-list.component';

const routes: Routes = [
  {
    path: 'recipes',
    component: RecipeListComponent,
  },
  {
    path: '',
    redirectTo: '/recipes',
    pathMatch: 'full',
  },
];

const config: ExtraOptions = {
  useHash: true,
  initialNavigation: 'disabled'
};

@NgModule({
  imports: [RouterModule.forRoot(routes, config)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
