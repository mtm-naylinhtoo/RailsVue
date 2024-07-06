import { createRouter, createWebHistory } from 'vue-router';
import UserSignup from '../views/UserSignup.vue';
import HelloWorld from '@/components/HelloWorld.vue';
import UserLogin from '../views/UserLogin.vue';
import PostIndex from '../views/PostIndex.vue';
import PostCreate from '../views/PostCreate.vue';
import PostShow from '../views/PostShow.vue';
import PostEdit from '../views/PostEdit.vue';

const routes = [
  {
    path: '/',
    name: 'Home',
    component: HelloWorld,
    props: { msg: 'Welcome to Your Vue.js App' }
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
    path: '/posts/:id/edit',
    name: 'EditPost',
    component: PostEdit,
    props: true,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
