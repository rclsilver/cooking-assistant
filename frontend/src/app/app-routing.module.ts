import { NgModule } from '@angular/core';
import { Routes, RouterModule, ExtraOptions } from '@angular/router';
import { AboutComponent } from './about/about.component';
import { RequireUserGuard } from './core/require-user.guard';
import { PageNotFoundComponent } from './errors/page-not-found/page-not-found.component';
import { RecipeFormComponent } from './recipe/form/form.component';
import { RecipeListComponent } from './recipe/list/list.component';

const routes: Routes = [
  {
    path: 'recipes',
    component: RecipeListComponent,
  },
  {
    path: 'recipes/add',
    component: RecipeFormComponent,
    canActivate: [ RequireUserGuard ]
  },
  {
    path: 'about',
    component: AboutComponent
  },
  {
    path: '',
    redirectTo: '/recipes',
    pathMatch: 'full'
  },
  {
    path: '**',
    component: PageNotFoundComponent
  }
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
