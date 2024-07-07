import { createRouter, createWebHistory } from 'vue-router';
import UserSignup from '../views/UserSignup.vue';
import HelloWorld from '@/components/HelloWorld.vue';
import UserLogin from '../views/UserLogin.vue';
import PostIndex from '../views/PostIndex.vue';
import PostCreate from '../views/PostCreate.vue';
import PostShow from '../views/PostShow.vue';
import PostEdit from '../views/PostEdit.vue';
import UserIndex from '../views/UserIndex.vue';
import UserShow from '../views/UserShow.vue';
import UserEdit from '../views/UserEdit.vue';

const routes = [
  {
    path: '/',
    name: 'Home',
    component: HelloWorld,
    props: { msg: 'Welcome to Your Social Media App 🥳' }
  },
  {
    path: '/signup',
    name: 'UserSignup',
    component: UserSignup
  },
  {
    path: '/login',
    name: 'UserLogin',
    component: UserLogin
  },
  {
    path: '/posts',
    name: 'PostIndex',
    component: PostIndex
  },
  {
    path: '/users',
    name: 'UserIndex',
    component: UserIndex
  },
  {
    path: '/posts/create',
    name: 'PostCreate',
    component: PostCreate
  },
  {
    path: '/posts/:id',
    name: 'ShowPost',
    component: PostShow,
    props: true,
  },
  {
    path: '/users/:id',
    name: 'ShowUser',
    component: UserShow,
    props: true,
  },
  {
    path: '/posts/:id/edit',
    name: 'EditPost',
    component: PostEdit,
    props: true,
  },
  {
    path: '/users/:id/edit',
    name: 'EditUser',
    component: UserEdit,
    props: true,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

// Navigation guard to check if user is authenticated
router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token');
  if (to.name !== 'UserLogin' && to.name !== 'UserSignup' && !token) {
    // Redirect to login if trying to access any route other than UserLogin and UserSignup without a token
    next({ name: 'UserLogin' });
  } else {
    next(); // Proceed to the requested route
  }
});

export default router;
