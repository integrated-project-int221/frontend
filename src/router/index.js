import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import NotFoundComponent from '../components/NotFoundComponent.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/teammember',
    name: 'TeamMember',
    component: () => import('../views/TeamMember.vue')
  },
  {
    path: '/addproduct',
    name: 'AddProduct',
    component: () => import('../views/AddProduct.vue')
  },
  {
    path: '/editproduct/:id',
    name: 'EditProduct',
    component: () => import('../views/EditProduct.vue'),
    props: true,

  },
  {
    path: '/:pathMatch(.*)*',
    name: 'NotFoundComponent',
    component: NotFoundComponent

  }
  
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
