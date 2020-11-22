import { Injectable } from '@angular/core';
import {
  ActivatedRouteSnapshot,
  CanActivate,
  RouterStateSnapshot,
} from '@angular/router';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';

import { AuthService } from './auth.service';

@Injectable()
export class RequireUserGuard implements CanActivate {
  constructor(private auth: AuthService) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean> {
    return this.auth.canActivateProtectedRoutes$.pipe(
      tap((x) =>
        console.log(
          'You tried to go to ' + state.url + ' and this guard said ' + x
        )
      )
    );
  }
}
