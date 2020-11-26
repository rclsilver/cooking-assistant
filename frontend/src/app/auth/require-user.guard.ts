import { Injectable } from '@angular/core';
import {
  ActivatedRouteSnapshot,
  CanActivate,
  RouterStateSnapshot,
} from '@angular/router';
import { combineLatest, Observable } from 'rxjs';
import { map } from 'rxjs/operators';

import { AuthService } from './auth.service';

@Injectable()
export class RequireUserGuard implements CanActivate {
  public canActivate$: Observable<boolean>;

  constructor(private auth: AuthService) {
    this.canActivate$ = combineLatest([
      this.auth.isDoneLoading$,
      this.auth.isAuthenticated$
    ]).pipe(map((values) => values.every((b) => b)));
  }

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean> {
    return this.canActivate$;
  }
}
