import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';

export const authGuard: CanActivateFn = (route, state) => {
  const router = inject(Router);

  if (typeof window !== 'undefined') {
    const token = localStorage.getItem("token");
    if (token !== ""){
      return true
    }
  }
  router.navigate(["/login"])
  return false;
};
