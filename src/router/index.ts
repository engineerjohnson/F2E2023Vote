import { createRouter, createWebHashHistory  } from 'vue-router'

const routes = [
  {
    path: '/',
    name: 'home',
    component: () => import("../views/HomeView.vue")
  },
]

const router = createRouter({
  history: createWebHashHistory(),
  linkActiveClass: "active",
  scrollBehavior() {
    return { top: 0 };
  },
  routes,
});

export default router;
